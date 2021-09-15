import 'package:current_cases_app/models/vaccine_group_model.dart';
import 'package:current_cases_app/providers/vaccine_provider.dart';
import 'package:current_cases_app/services/data_service.dart';
import 'package:current_cases_app/models/summary_model.dart';
import 'package:current_cases_app/widgets/vaxx_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:current_cases_app/data/health_region_data.dart'
    as healthRegionData;
import 'package:provider/provider.dart';

class VaxScreen extends StatefulWidget {
  @override
  _VaxScreenState createState() => _VaxScreenState();
}

class _VaxScreenState extends State<VaxScreen> {
  DateTime selectedDate = DateTime.now();
  Future<Summary> futSummary =
      DataService().getProvinceSummary('MB', DateTime.now());
  var format = DateFormat.yMMMMd('en_US');
  String _selectedGroup = 'Adults_18plus';

  @override
  void initState() {
    super.initState();

    Provider.of<VaccineGroupProvider>(context, listen: false)
        .getNewVaccineData();
    Provider.of<VaccineProvider>(context, listen: false).getNewVaccineData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _titleBar(),
          _header(),
          _vaxCard(),
          // _barChart(),
        ],
      ),
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
            onPressed: () => {} //_selectDate(),;
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
                // Container(
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                //   child: DropdownButtonHideUnderline(
                //     child: DropdownButton<String>(
                //       value: _province,
                //       items: _provinces
                //           .map(
                //             (e) => DropdownMenuItem(
                //               child: Row(
                //                 children: <Widget>[
                //                   Container(
                //                     padding:
                //                         EdgeInsets.symmetric(horizontal: 10.0),
                //                     height: 40.0,
                //                     width: 40.0,
                //                     child: Image.asset(
                //                       'assets/images/$e.jpg',
                //                     ),
                //                   ),
                //                   Text(
                //                     e,
                //                     style: TextStyle(
                //                         fontFamily: 'Futura', fontSize: 15),
                //                   ),
                //                 ],
                //               ),
                //               value: e,
                //             ),
                //           )
                //           .toList(),
                //       onChanged: (String value) {
                //         setState(() {
                //           _province = value;
                //           futSummary = DataService()
                //               .getProvinceSummary(value, selectedDate);
                //         });
                //       },
                //     ),
                //   ),
                // ),
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

  // SliverToBoxAdapter _barChart() {
  //   return SliverToBoxAdapter(
  //     child: Column(
  //       children: [
  //         FutureBuilder(
  //           future: DataService().getVaccineList(_province), // async work
  //           builder: (context, snapshot) {
  //             switch (snapshot.connectionState) {
  //               case ConnectionState.waiting:
  //                 return Center(
  //                   child: CircularProgressIndicator(),
  //                 );
  //               default:
  //                 if (snapshot.hasError)
  //                   return Text('Error: ${snapshot.error}');
  //                 else {
  //                   List<Vaccine> data = snapshot.data;
  //                   var df = new DateFormat('dd-MM-yyyy');

  //                   List<charts.Series<Vaccine, DateTime>> _createSampleData() {
  //                     return [
  //                       charts.Series(
  //                           id: "Vaccinations",
  //                           data: data,
  //                           domainFn: (Vaccine vax, _) =>
  //                               df.parse(vax.dateVaccineAdministered),
  //                           measureFn: (Vaccine vax, _) => vax.avaccine),
  //                     ];
  //                   }

  //                   return Container(
  //                     padding: EdgeInsets.all(10.0),
  //                     child: Column(
  //                       children: <Widget>[
  //                         SizedBox(
  //                           height: 100.0,
  //                         ),
  //                         Text(
  //                           "Vaccinations Per Day",
  //                           style: TextStyle(
  //                             color: Colors.black,
  //                             fontSize: 12.0,
  //                             fontFamily: 'Futura',
  //                           ),
  //                         ),
  //                         Container(
  //                           height: 400.0,
  //                           child: charts.TimeSeriesChart(_createSampleData(),
  //                               animate: true),
  //                         )
  //                       ],
  //                     ),
  //                   );
  //                 }
  //             }
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Container dropDownMenu() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Color(0xff41b3a3),
        borderRadius: BorderRadius.circular(17),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: Color(0xff41b3a3),
          value: _selectedGroup,
          items: healthRegionData.groups
              .map(
                (e) => DropdownMenuItem(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          e,
                          style: TextStyle(
                            fontFamily: 'Futura',
                            fontSize: 15,
                            color: Colors.white,
                          ),
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
              _selectedGroup = value;
            });
          },
        ),
      ),
    );
  }

  SliverToBoxAdapter _vaxCard() {
    return SliverToBoxAdapter(
      child: Consumer2<VaccineProvider, VaccineGroupProvider>(
        builder: (context, vaccine, group, child) {
          VaccineGroup currentGroup = group.vaxGroup[_selectedGroup];

          return group.loading || vaccine.loading
              ? Center(
                  child: Container(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(
                  children: [
                    dropDownMenu(),
                    VaxxCard(
                      label: 'total at least one',
                      stat: currentGroup.date,
                      percentage: currentGroup.percentAtLeastOneDose,
                      animationTime: (1000),
                      color: Color(0xffe8a87c),
                      tapFunction: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('More detail'),
                              content: stageAlertDialog(currentGroup),
                            );
                          },
                        );
                      },
                    ),
                    VaxxCard(
                      label: 'total double',
                      stat: 'total double',
                      percentage: currentGroup.percentFullyVaccinated,
                      animationTime: (1000),
                      color: Color(0xff9ad9db),
                      tapFunction: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('More detail'),
                              content: stageAlertDialog(currentGroup),
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
        },
      ),
    );
  }

  Widget stageAlertDialog(VaccineGroup input) {
    List info = [
      'Total one dose',
      'Total second dose',
      'Total population',
    ];

    List vaccineInfo = [
      input.atLeastOneDoseCumulative,
      input.secondDoseCumulative,
      input.totalPopulation
    ];

    var f = NumberFormat("###,###,###", "en_US");
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: info.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
                info[index] + ' - ' + f.format(vaccineInfo[index]).toString()),
          );
        },
      ),
    );
  }
}
