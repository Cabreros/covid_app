import 'package:current_cases_app/services/data_service.dart';
import 'package:current_cases_app/services/ontario_service.dart';
import 'package:current_cases_app/services/summary_model.dart';
import 'package:current_cases_app/services/vaccine_model.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:current_cases_app/services/health_region_data.dart'
    as healthRegionData;
import 'package:percent_indicator/percent_indicator.dart';

class VaxScreen extends StatefulWidget {
  @override
  _VaxScreenState createState() => _VaxScreenState();
}

class _VaxScreenState extends State<VaxScreen> {
  DateTime selectedDate = DateTime.now();
  List<String> _provinces = healthRegionData.provinces;
  Future<Summary> futSummary =
      DataService().getProvinceSummary('MB', DateTime.now());
  var format = DateFormat.yMMMMd('en_US');
  String _province = 'ON';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _titleBar(),
          _header(),
          _vaxCharts(),
          _barChart(),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Color(0xffe27d60),
      //   onPressed: () => _selectDate(context),
      //   child: const Icon(Icons.calendar_today_rounded),
      // ),
    );
  }

  SliverAppBar _titleBar() {
    return SliverAppBar(
      backgroundColor: Color(0xffe27d60),
      title: Text(
        'Vaccinations',
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

  SliverToBoxAdapter _barChart() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          FutureBuilder(
              future: DataService().getVaccineList(_province), // async work
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else {
                      List<Vaccine> data = snapshot.data;
                      var df = new DateFormat('dd-MM-yyyy');

                      List<charts.Series<Vaccine, DateTime>>
                          _createSampleData() {
                        return [
                          charts.Series(
                              id: "Vaccinations",
                              data: data,
                              domainFn: (Vaccine vax, _) =>
                                  df.parse(vax.dateVaccineAdministered),
                              measureFn: (Vaccine vax, _) => vax.avaccine),
                        ];
                      }

                      return Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 100.0,
                            ),
                            Text(
                              "Vaccinations Per Day",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontFamily: 'Futura',
                              ),
                            ),
                            Container(
                              height: 400.0,
                              child: charts.TimeSeriesChart(_createSampleData(),
                                  animate: true),
                            )
                          ],
                        ),
                      );
                    }
                }
              }),
        ],
      ),
    );
  }

  //pie chart
  SliverToBoxAdapter _vaxCharts() {
    return SliverToBoxAdapter(
      child: FutureBuilder(
          future:
              OntarioService().getVaccinationData(selectedDate), // async work
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
                  var summary = snapshot.data[0];
                  double percentage =
                      double.parse(summary['total_individuals_at_least_one']) /
                          13034844;
                  return Container(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Vaccinations By The Numbers',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontFamily: 'Futura',
                          ),
                        ),
                        Text(summary.toString()),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: new LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width - 75,
                            animation: true,
                            lineHeight: 20.0,
                            animationDuration: 2500,
                            percent: percentage,
                            center: Text(
                                (percentage * 100).toStringAsFixed(1) + '%'),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  );
                }
            }
          }),
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
