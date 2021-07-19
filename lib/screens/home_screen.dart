import 'package:current_cases_app/services/data_service.dart';
import 'package:current_cases_app/services/health_region_data.dart'
    as healthRegionData;
import 'package:current_cases_app/services/ontario_service.dart';
import 'package:current_cases_app/services/summary_model.dart';
import 'package:current_cases_app/widgets/stats_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
          _newApiTest(),
          _reopeningPages()
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

  SliverToBoxAdapter _newApiTest() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          FutureBuilder(
            future:
                OntarioService().getCaseData(new DateTime.now()), // async work
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
                    return Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(snapshot.data.toString()),
                    );
                  }
              }
            },
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter _reopeningPages() {
    PageController controller = PageController();

    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              controller: controller,
              itemBuilder: (context, index) {
                return Container(
                  // padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.yellow,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  width: MediaQuery.of(context).size.width - 20,
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              'Vaccination rate plus key public health and health care indicators'),
                          Text('Step 1'),
                          Text('60%'),
                          Text('Adults with one dose'),
                        ],
                      ),
                    ),
                    Container(
                      height: 20,
                      width: 5000,
                      color: Colors.white,
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.0),
                          color: Colors.yellow,
                          child: Column(
                            children: [
                              Text('Permit with restrictions'),
                              Text(
                                  'Outdoor spaces begin reopening, limited indoor settings with restrictions')
                            ],
                          ),
                        ),
                      ],
                    )
                  ]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SmoothPageIndicator(
                controller: controller, // PageController
                count: 3,
                effect: ExpandingDotsEffect(), // your preferred effect
                onDotClicked: (index) {}),
          ),
        ],
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
