import 'package:current_cases_app/models/case_model.dart';
import 'package:current_cases_app/models/status_model.dart';
import 'package:current_cases_app/models/vaccine_group_model.dart';
import 'package:current_cases_app/providers/case_provider.dart';
import 'package:current_cases_app/providers/status_provider.dart';
import 'package:current_cases_app/providers/vaccine_provider.dart';
import 'package:current_cases_app/services/data_service.dart';
import 'package:current_cases_app/data/health_region_data.dart'
    as healthRegionData;
import 'package:current_cases_app/data/reopening_data.dart';
import 'package:current_cases_app/models/summary_model.dart';
import 'package:current_cases_app/widgets/stats_card.dart';
import 'package:current_cases_app/widgets/vaxx_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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
          _appBar(),
          _header(),
          _bodyStats(_province),
          _totalVaccinationStats(),
          _reopeningPages()
        ],
      ),
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
                        setState(
                          () {
                            _province = value;
                            futSummary = DataService()
                                .getProvinceSummary(value, selectedDate);
                          },
                        );
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
    Widget dailySummary;
    if (province == 'ON') {
      dailySummary = Consumer2<StatusProvider, CaseProvider>(
        builder: (context, status, cases, child) {
          status.getStatusData();
          cases.getCaseData();
          CaseData caseStats = cases.caseData;
          Status currentStatus = status.statusData;
          return (status.isLoaded && cases.isLoaded)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
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
                            'There are ${caseStats.total} new cases in Ontario.',
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
                          stat: currentStatus.confirmedPositive?.toInt(),
                          color: Color(0xffc38d9e),
                        ),
                        StatsCard(
                          label: 'Recovered',
                          stat: currentStatus.resolved.toString(),
                          color: Color(0xff9ad9db),
                        ),
                        StatsCard(
                          label: 'Deaths',
                          stat: currentStatus.deaths.toString(),
                          color: Color(0xffd44000),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        StatsCard(
                          label: 'Total Cases',
                          stat: currentStatus.totalCases.toString(),
                        ),
                        StatsCard(
                          label: 'Total Deaths',
                          stat: currentStatus.deaths.toString(),
                          color: Color(0xffe8a87c),
                        ),
                      ],
                    ),
                  ],
                );
        },
      );
    } else {
      dailySummary = otherProvince(province);
    }

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
        child: dailySummary,
      ),
    );
  }

  FutureBuilder<Summary> otherProvince(province) {
    return FutureBuilder(
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
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
    );
  }

  SliverToBoxAdapter _totalVaccinationStats() {
    return SliverToBoxAdapter(
      child: Consumer2<VaccineProvider, VaccineGroupProvider>(
        builder: (context, vaccine, group, child) {
          VaccineGroup ont12Plus = group.vaxGroup['Ontario_12plus'];

          return group.loading && vaccine.loading
              ? Center(
                  child: Container(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Vaccination Overview',
                      style: TextStyle(fontSize: 17),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('More details'),
                                content: stageAlertDialog(0),
                              );
                            });
                      },
                      child: VaxxCard(
                        label: 'At least one dose cumulative',
                        stat: 'Ontario 12+',
                        percentage: ont12Plus.percentAtLeastOneDose,
                        animationTime: (1000),
                        color: Color(0xffe8a87c),
                      ),
                    ),
                    VaxxCard(
                      label: 'Fully vaccinated',
                      stat: 'Ontario 12+',
                      percentage: ont12Plus.percentFullyVaccinated,
                      animationTime: (1000),
                      color: Color(0xff9ad9db),
                    ),
                  ],
                );
        },
      ),
    );
  }

  SliverToBoxAdapter _reopeningPages() {
    PageController controller = PageController(initialPage: 2);

    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: 200,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              controller: controller,
              itemBuilder: (context, index) {
                return Container(
                  // padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Reopening().colors1[index],
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  width: MediaQuery.of(context).size.width - 20,
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              'Vaccination rate plus key public health and health care indicators'),
                          Text(
                            'Step ${index + 1}',
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            Reopening().percentages[index],
                            style: TextStyle(fontSize: 25),
                          ),
                          Text(
                            'Adults with one dose',
                            textAlign: TextAlign.center,
                          ),
                          Text(Reopening().percentages2[index]),
                          SizedBox(
                            height: 7,
                          ),
                          ElevatedButton(
                              // style: ,
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                            'Stage ${index + 1} - Key Highlights'),
                                        content: stageAlertDialog(index),
                                      );
                                    });
                              },
                              child: Text(
                                  'Click for detailed stage ${index + 1} information'))
                        ],
                      ),
                    ),
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

  Widget stageAlertDialog(number) {
    List steps = [Reopening().step1, Reopening().step2, Reopening().step3];
    return Container(
      height: MediaQuery.of(context).size.height * .60,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: steps[number].length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('\u2022 ' + steps[number][index]),
          );
        },
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
