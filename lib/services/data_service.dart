import 'dart:convert';

import 'package:current_cases_app/services/summary_model.dart';
import 'package:current_cases_app/services/vaccine_model.dart';
import 'package:http/http.dart' as http;

import 'health_region_model.dart';

class DataService {
  Future<List<Summary>> getSummary() async {
    final uri = Uri.https('api.opencovid.ca', '/summary');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['summary'];

      List<Summary> allSummary = body
          .map(
            (dynamic item) => Summary.fromJson(item),
          )
          .toList();

      return allSummary;
    } else {
      throw "unable to retrieve posts.";
    }
  }

  Future<List<Vaccine>> getVaccineList(province) async {
    Map<String, String> requestHeaders = {
      'loc': province,
      'after': '2021-03-15',
      'stat': 'avaccine'
    };
    final uri = Uri.https('api.opencovid.ca', '/timeseries', requestHeaders);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['avaccine'];

      List<Vaccine> allVaccine = body
          .map(
            (dynamic item) => Vaccine.fromJson(item),
          )
          .toList();

      return allVaccine;
    } else {
      throw "unable to retrieve posts.";
    }
  }

  Future<HealthRegion> getHealthCodeSummary(int num, [DateTime date]) async {
    Map<String, String> requestHeaders;

    if (date != null) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final aDate = DateTime(date.year, date.month, date.day);

      if (aDate == today) {
        date = date.subtract(Duration(
          days: 1,
        ));
      }

      String day = date.day.toString();
      String month = date.month.toString();
      String year = date.year.toString();

      if (day.length == 1) {
        day = '0' + day;
      }
      if (month.length == 1) {
        month = '0' + month;
      }

      requestHeaders = {
        'loc': num.toString(),
        'date': day + '-' + month + '-' + year,
      };
    } else {
      requestHeaders = {
        'loc': num.toString(),
      };
    }

    final uri = Uri.https('api.opencovid.ca', '/summary', requestHeaders);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body)['summary'];

      if (body.length < 1) {
        return null;
      } else {
        return HealthRegion.fromJson(body[0]);
      }
    } else {
      throw "unable to retrieve posts.";
    }
  }

  Future<Summary> getProvinceSummary(String province, [DateTime date]) async {
    Map<String, String> requestHeaders;

    if (date != null) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final aDate = DateTime(date.year, date.month, date.day);

      if (aDate == today) {
        date = date.subtract(Duration(
          days: 1,
        ));
      }

      String day = date.day.toString();
      String month = date.month.toString();
      String year = date.year.toString();

      if (day.length == 1) {
        day = '0' + day;
      }
      if (month.length == 1) {
        month = '0' + month;
      }

      requestHeaders = {
        'loc': province,
        'date': day + '-' + month + '-' + year,
      };
    } else {
      requestHeaders = {
        'loc': province,
      };
    }

    final uri = Uri.https('api.opencovid.ca', '/summary', requestHeaders);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body)['summary'];

      if (body.length < 1) {
        return null;
      } else {
        return Summary.fromJson(body[0]);
      }
    } else {
      throw "unable to retrieve posts.";
    }
  }
}
