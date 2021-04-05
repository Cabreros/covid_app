import 'package:current_cases_app/services/data_service.dart';
import 'package:current_cases_app/services/summary_model.dart';
import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FutureAllProvinces(),
      ),
    );
  }
}

class FutureAllProvinces extends StatelessWidget {
  const FutureAllProvinces({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DataService().getSummary(),
      builder: (
        context,
        snapshot,
      ) {
        if (snapshot.hasData) {
          List<Summary> posts = snapshot.data;
          return ListView(
            children: posts
                .map(
                  (Summary post) => Text(
                    post.province,
                  ),
                )
                .toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class FutureProvince extends StatelessWidget {
  const FutureProvince({
    @required this.province,
    Key key,
  }) : super(key: key);
  final String province;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DataService().getProvinceSummary(province), // async work
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading....');
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else {
              return Text(snapshot.data.province);
            }
        }
      },
    );
  }
}
