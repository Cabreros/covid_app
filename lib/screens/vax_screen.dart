import 'package:current_cases_app/services/chart_testing_data.dart';
import 'package:current_cases_app/services/data_service.dart';
import 'package:current_cases_app/services/vaccine_model.dart';
import 'package:flutter/material.dart';

class VaxScreen extends StatefulWidget {
  @override
  _VaxScreenState createState() => _VaxScreenState();
}

class _VaxScreenState extends State<VaxScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: DataService().getVaccineList(), // async work
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
                  return Container(
                    child: Text(summary[0].avaccine.toString()),
                  );
                }
            }
          }),
    );
  }
}
