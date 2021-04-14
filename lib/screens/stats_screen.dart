import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:current_cases_app/services/chart_testing_data.dart' as data;

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _appBar(),
          _chartTest(),
        ],
      ),
    );
  }
}

SliverAppBar _appBar() {
  return SliverAppBar(
    backgroundColor: Color(0xffe27d60),
    title: Text(
      'Data Visualized',
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

SliverToBoxAdapter _chartTest() {
  return SliverToBoxAdapter(
    child: Container(
      height: 1000.0,
      decoration: BoxDecoration(
        color: Colors.black,
      ),
    ),
  );
}
