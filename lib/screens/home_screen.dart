import 'package:current_cases_app/services/data_service.dart';
import 'package:current_cases_app/services/health_region_data.dart'
    as healthRegionData;
import 'package:current_cases_app/services/summary_model.dart';
import 'package:current_cases_app/widgets/stats_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _province = 'ON';
  List<String> _provinces = healthRegionData.provinces;
  DateTime selectedDate = DateTime.now();
  Future<Summary> futSummary =
      DataService().getProvinceSummary('MB', DateTime.now());
  var format = DateFormat.yMMMMd('en_US');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _appBar(),
          _header(),
          _bodyStats(_province),
          _vaxCharts(),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Color(0xffe27d60),
      //   onPressed: () => _selectDate(context),
      //   child: const Icon(Icons.calendar_today_rounded),
      // ),
    );
  }

  SliverAppBar _appBar() {
    return SliverAppBar(
      backgroundColor: Color(0xffe27d60),
      title: Text(
        'Daily Summary',
        style: TextStyle(
          color: Colors.white,
          fontSize: 23.0,
          fontFamily: 'Futura',
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.calendar_today_rounded),
          onPressed: () => _selectDate(context),
        )
      ],
      floating: true,
    );
  }

  SliverToBoxAdapter _header() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
          color: Color(0xffe27d60),
          // borderRadius: BorderRadius.only(
          //   bottomLeft: Radius.circular(25.0),
          //   bottomRight: Radius.circular(25.0),
          // ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    format.format(selectedDate),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontFamily: 'Futura',
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _province,
                      items: _provinces
                          .map(
                            (e) => DropdownMenuItem(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    height: 40.0,
                                    width: 40.0,
                                    child: Image.asset(
                                      'assets/images/$e.jpg',
                                    ),
                                  ),
                                  Text(
                                    e,
                                    style: TextStyle(
                                        fontFamily: 'Futura', fontSize: 15),
                                  ),
                                ],
                              ),
                              value: e,
                            ),
                          )
                          .toList(),
                      onChanged: (String value) {
                        setState(() {
                          _province = value;
                          futSummary = DataService()
                              .getProvinceSummary(value, selectedDate);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _bodyStats(province) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
          color: Color(0xffe27d60),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
        child: FutureBuilder(
          future: DataService()
              .getProvinceSummary(province, selectedDate), // async work
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 40,
                    )
                  ],
                );
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else {
                  var summary = snapshot.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(8.0),
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Color(0xff7eca9c),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'There are ${summary.cases} new cases in ${summary.province}.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontFamily: 'Futura',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          StatsCard(
                            label: 'Active',
                            stat: summary.activeCases.toInt().toString(),
                            color: Color(0xffc38d9e),
                          ),
                          StatsCard(
                            label: 'Recovered',
                            stat: summary.culRecovered.toInt().toString(),
                            color: Color(0xff9ad9db),
                          ),
                          StatsCard(
                            label: 'Deaths',
                            stat: summary.deaths.toInt().toString(),
                            color: Color(0xffd44000),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          StatsCard(
                            label: 'Total Cases',
                            stat: summary.culCases.toInt().toString(),
                          ),
                          StatsCard(
                            label: 'Total Deaths',
                            stat: summary.culDeaths.toInt().toString(),
                            color: Color(0xffe8a87c),
                          ),
                        ],
                      ),
                    ],
                  );
                }
            }
          },
        ),
      ),
    );
  }

  SliverToBoxAdapter _vaxCharts() {
    MediaQueryData queryData = MediaQuery.of(context);
    var formatter = NumberFormat('###,###,000');

    List<charts.Series<Vax, String>> _createSampleData() {
      final data = [
        new Vax(7576624, 'Single Dose'),
        new Vax(473759, 'Double Dose'),
        new Vax(14745040 - 473759 - 7576624, 'Rest of Pop')
      ];

      return [
        new charts.Series<Vax, String>(
          id: 'Sales',
          domainFn: (Vax sales, _) => sales.label,
          measureFn: (Vax sales, _) => sales.pop,
          data: data,
          labelAccessorFn: (Vax sales, _) => '${formatter.format(sales.pop)}',
        )
      ];
    }

    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Current Vaccinations By The Numbers',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontFamily: 'Futura',
                  ),
                ),
                SizedBox(
                  height: 300,
                  width: queryData.size.width - 50,
                  child: charts.PieChart(
                    _createSampleData(),
                    animate: false,
                    defaultRenderer: new charts.ArcRendererConfig(
                      arcWidth: 60,
                      arcRendererDecorators: [new charts.ArcLabelDecorator()],
                    ),
                    behaviors: [
                      new charts.DatumLegend(
                        // Positions for "start" and "end" will be left and right respectively
                        // for widgets with a build context that has directionality ltr.
                        // For rtl, "start" and "end" will be right and left respectively.
                        // Since this example has directionality of ltr, the legend is
                        // positioned on the right side of the chart.
                        position: charts.BehaviorPosition.end,
                        // For a legend that is positioned on the left or right of the chart,
                        // setting the justification for [endDrawArea] is aligned to the
                        // bottom of the chart draw area.
                        outsideJustification:
                            charts.OutsideJustification.endDrawArea,
                        // By default, if the position of the chart is on the left or right of
                        // the chart, [horizontalFirst] is set to false. This means that the
                        // legend entries will grow as new rows first instead of a new column.
                        horizontalFirst: false,
                        // By setting this value to 2, the legend entries will grow up to two
                        // rows before adding a new column.
                        desiredMaxRows: 3,
                        // This defines the padding around each legend entry.
                        cellPadding:
                            new EdgeInsets.only(right: 4.0, bottom: 4.0),
                        // Render the legend entry text with custom styles.
                        entryTextStyle: charts.TextStyleSpec(
                            color: charts.MaterialPalette.black,
                            fontFamily: 'Futura',
                            fontSize: 12),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 3),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}

class Vax {
  final int pop;
  final String label;

  Vax(this.pop, this.label);
}
