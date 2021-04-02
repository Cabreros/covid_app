import 'package:current_cases_app/services/data_service.dart';
import 'package:current_cases_app/services/summary_model.dart';
import 'package:current_cases_app/widgets/stats_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _dataService = DataService();
  List<Summary> _response;
  String _province = 'ON';
  List<String> _provinces = ['ON', 'YK', 'AB', 'QC'];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomScrollView(
        slivers: [_appBar(), _header(), _body()],
      ),
    );
  }

  SliverAppBar _appBar() {
    return SliverAppBar(
      backgroundColor: Color(0xffe27d60),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: null,
        )
      ],
      //title: Text('Floating app bar'),
      floating: true,
    );
  }

  SliverToBoxAdapter _header() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        height: 100.0,
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
                    'COVID-19',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 27.0,
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
                        setState(() => _province = value);
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Current Case Statistics',
              style: TextStyle(
                color: Colors.white,
                fontSize: 23.0,
                fontFamily: 'Futura',
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _body() {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                StatsCard(
                  label: 'Active Cases',
                  stat: 25744,
                ),
                StatsCard(
                  label: 'Active Cases',
                  stat: 25744,
                  color: Color(0xffc38d9e),
                ),
              ],
            ),
            Row(
              children: [
                StatsCard(
                  label: 'Active Cases',
                  stat: 25744,
                ),
                StatsCard(
                  label: 'Active Cases',
                  stat: 25744,
                  color: Color(0xffc38d9e),
                ),
                StatsCard(
                  label: 'Active Cases',
                  stat: 25744,
                  color: Color(0xffc38d9e),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _makeRequest() async {
    final response = await _dataService.getSummary();
    setState(() {
      _response = response;
    });
  }
}
