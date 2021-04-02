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
        child: FutureBuilder(
          future: DataService().getSummary(),
          builder: (
            BuildContext context,
            AsyncSnapshot<List<Summary>> snapshot,
          ) {
            if (snapshot.hasData) {
              List<Summary> posts = snapshot.data;
              return ListView(
                children: posts
                    .map(
                      (Summary post) => Text(
                        post.toString(),
                      ),
                    )
                    .toList(),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
