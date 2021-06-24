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
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffe27d60),
        onPressed: () => _selectDate(context),
        child: const Icon(Icons.calendar_today_rounded),
      ),
      body: Column(
        children: [
          FutureBuilder(
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
                      List<Vaccine> data = snapshot.data;
                      var df = new DateFormat('dd-MM-yyyy');
                      List<charts.Series<Vaccine, DateTime>> series = [
                        charts.Series(
                            id: "Vaccinations",
                            data: data,
                            domainFn: (Vaccine vax, _) =>
                                df.parse(vax.dateVaccineAdministered),
                            measureFn: (Vaccine vax, _) => vax.avaccine),
                      ];
                      return Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 100.0,
                            ),
                            Text(
                              "Vaccinations Per Day",
                            ),
                            Container(
                              height: 400.0,
                              child:
                                  charts.TimeSeriesChart(series, animate: true),
                            )
                          ],
                        ),
                      );
                    }
                }
              }),
        ],
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
