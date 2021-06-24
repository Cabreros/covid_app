import 'package:current_cases_app/services/data_service.dart';
import 'package:current_cases_app/widgets/stats_card.dart';
import 'package:current_cases_app/services/health_region_data.dart'
    as healthRegionData;
import 'package:current_cases_app/services/health_region_model.dart';
import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  DateTime selectedDate = DateTime.now();
  String _region = 'ON - Toronto';
  var _healthRegionData = healthRegionData.regionData;
  Future<HealthRegion> healthRegionSummary =
      DataService().getHealthCodeSummary(3595, DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [_appBar(), _zoneByCode(_region)],
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
        'Specific Region Data',
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

  SliverToBoxAdapter _zoneByCode(region) {
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
          future: DataService().getHealthCodeSummary(
            healthRegionData.regionData[region],
            selectedDate,
          ),
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
                    ),
                  ],
                );
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else {
                  var regionSummary = snapshot.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: Color(0xffe27d60),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              dropdownColor: Color(0xffe27d60),
                              value: _region,
                              items: _healthRegionData.keys
                                  .toList()
                                  .map(
                                    (e) => DropdownMenuItem(
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            e,
                                            style: TextStyle(
                                              fontFamily: 'Futura',
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      value: e,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (String value) {
                                setState(() {
                                  _region = value;
                                  healthRegionSummary =
                                      DataService().getHealthCodeSummary(
                                    _healthRegionData[value],
                                    selectedDate,
                                  );
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //   padding: EdgeInsets.symmetric(
                      //       horizontal: 10.0, vertical: 5.0),
                      //   child: Text(
                      //     'Region Summary',
                      //     style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 20.0,
                      //       fontFamily: 'Futura',
                      //     ),
                      //   ),
                      // ),
                      Row(
                        children: [
                          StatsCard(
                            label: 'Cases',
                            stat: regionSummary.cases.toString(),
                            color: Color(0xffc38d9e),
                          ),
                          StatsCard(
                            label: 'Deaths',
                            stat: regionSummary.deaths.toInt().toString(),
                            color: Color(0xffe27d60),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          StatsCard(
                            label: 'Total Cases',
                            stat: regionSummary.culCases.toString(),
                          ),
                          StatsCard(
                            label: 'Total Deaths',
                            stat: regionSummary.culDeaths.toInt().toString(),
                            color: Color(0xffe8a87c),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 3.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Updated as of: ' + regionSummary.date.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontFamily: 'Futura',
                              ),
                            ),
                            Text(
                              'Data provided by opencovid.ca',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontFamily: 'Futura',
                              ),
                            ),
                          ],
                        ),
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
