import 'package:current_cases_app/services/data_service.dart';
import 'package:current_cases_app/services/summary_model.dart';
import 'package:current_cases_app/widgets/stats_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _province = 'MB';
  List<String> _provinces = ['AB', 'BC', 'MB', 'NB', 'ON', 'QC', 'YT'];
  DateTime selectedDate = DateTime.now();
  Future<Summary> futSummary =
      DataService().getProvinceSummary('MB', DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _appBar(),
          _header(),
          _bodyStats(_province),
          _zoneByCode(_province)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffe27d60),
        onPressed: () => _selectDate(context),
        child: const Icon(Icons.calendar_today_rounded),
      ),
    );
  }

  SliverAppBar _appBar() {
    return SliverAppBar(
      backgroundColor: Color(0xffe27d60),
      title: Text(
        'Current Case Statistics',
        style: TextStyle(
          color: Colors.white,
          fontSize: 23.0,
          fontFamily: 'Futura',
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: null,
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
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    'Daily Summary',
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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
        child: FutureBuilder(
          future: DataService()
              .getProvinceSummary(province, DateTime.now()), // async work
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
                  var summary = snapshot.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Text(
                          'Updated as of: ' +
                              summary.date.toString() +
                              'selected date ' +
                              selectedDate.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.0,
                            fontFamily: 'Futura',
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
                            color: Color(0xff85dcba),
                          ),
                          StatsCard(
                            label: 'Deaths',
                            stat: summary.deaths.toInt().toString(),
                            color: Color(0xffe27d60),
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

  SliverToBoxAdapter _zoneByCode(_province) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
        child: FutureBuilder(
          future: futSummary,
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
                  var summary = snapshot.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Text(
                          'Health Region Summary',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontFamily: 'Futura',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Text(
                          'Updated as of: ' +
                              summary.date.toString() +
                              'selected date ' +
                              selectedDate.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.0,
                            fontFamily: 'Futura',
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
                            color: Color(0xff85dcba),
                          ),
                          StatsCard(
                            label: 'Deaths',
                            stat: summary.deaths.toInt().toString(),
                            color: Color(0xffe27d60),
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

  SliverToBoxAdapter _datePicker() {
    return SliverToBoxAdapter(
      child: Container(
        height: 25.0,
        child: ElevatedButton(
          onPressed: () => _selectDate(context),
          child: Text('Select date'),
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
