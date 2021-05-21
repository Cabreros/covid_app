import 'package:current_cases_app/services/data_service.dart';
import 'package:current_cases_app/services/vaccine_model.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class VaxScreen extends StatefulWidget {
  @override
  _VaxScreenState createState() => _VaxScreenState();
}

class _VaxScreenState extends State<VaxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
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
                  List<Vaccine> data = summary;
                  var df = new DateFormat('dd-MM-yyyy');
                  List<charts.Series<Vaccine, DateTime>> series = [
                    charts.Series(
                        id: "Vaccinations",
                        data: data,
                        domainFn: (Vaccine vax, _) =>
                            df.parse(vax.dateVaccineAdministered),
                        measureFn: (Vaccine vax, _) => vax.avaccine)
                  ];
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Vaccinations Per Day",
                        ),
                        Container(
                          height: 400.0,
                          child: charts.TimeSeriesChart(series, animate: true),
                        )
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }
}
