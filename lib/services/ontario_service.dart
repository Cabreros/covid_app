import 'dart:convert';
import 'package:current_cases_app/models/case_model.dart';
import 'package:current_cases_app/models/new_vaccine_model.dart';
import 'package:http/http.dart' as http;

class OntarioService {
  // Future<dynamic> getCaseData([DateTime date]) async {
  //   Map<String, String> requestHeaders;

  //   if (date != null) {
  //     final now = DateTime.now();

  //     String day = now.day.toString();
  //     String month = now.month.toString();
  //     String year = now.year.toString();

  //     if (day.length == 1) {
  //       day = '0' + day;
  //     }
  //     if (month.length == 1) {
  //       month = '0' + month;
  //     }

  //     requestHeaders = {
  //       'resource_id': '8a88fe6d-d8fb-41a3-9d04-f0550a44999f',
  //       'q': year + '-' + month + '-' + day,
  //       'limit': '5',
  //     };
  //   } else {
  //     requestHeaders = {
  //       'resource_id': '8a88fe6d-d8fb-41a3-9d04-f0550a44999f',
  //       'limit': '5',
  //     };
  //   }

  //   final uri = Uri.https(
  //       'data.ontario.ca', '/api/3/action/datastore_search', requestHeaders);
  //   final response = await http.get(uri);

  //   if (response.statusCode == 200) {
  //     var body = jsonDecode(response.body)['result']['records'];

  //     if (body.length == null) {
  //       return 'Error getting cases';
  //     } else if (body.length > 1) {
  //       var json;
  //       for (var result in body) {
  //         int highest = 0;
  //         int id = result['_id'];

  //         if (id > highest) {
  //           highest = id;
  //           json = result;
  //         }
  //         return json;
  //       }
  //     } else {
  //       return body;
  //     }
  //   } else {
  //     throw "unable to retrieve posts.";
  //   }
  // }

  Future<NewVaccine> getVaccinationData() async {
    Map<String, String> requestHeaders;

    requestHeaders = {
      'resource_id': '8a89caa9-511c-4568-af89-7f2174b4378c',
      'limit': '5',
      'sort': '_id desc'
    };

    final uri = Uri.https(
        'data.ontario.ca', '/api/3/action/datastore_search', requestHeaders);
    final response = await http.get(uri);

    try {
      var body = jsonDecode(response.body)['result']['records'][0];

      return NewVaccine.fromJson(body);
    } catch (e) {
      return e;
    }
  }

  Future<CaseData> getCaseData() async {
    Map<String, String> requestHeaders;

    requestHeaders = {
      'resource_id': '8a88fe6d-d8fb-41a3-9d04-f0550a44999f',
      'limit': '5',
      'sort': '_id desc'
    };

    final uri = Uri.https(
        'data.ontario.ca', '/api/3/action/datastore_search', requestHeaders);
    final response = await http.get(uri);

    try {
      var body = jsonDecode(response.body)['result']['records'][0];

      return CaseData.fromJson(body);
    } catch (e) {
      return e;
    }
  }

  Future<CaseData> getOntarioData() async {
    Map<String, String> requestHeaders;

    requestHeaders = {
      'resource_id': '8a89caa9-511c-4568-af89-7f2174b4378c',
      'limit': '5',
      'sort': '_id desc'
    };

    final uri = Uri.https(
        'data.ontario.ca', '/api/3/action/datastore_search', requestHeaders);
    final response = await http.get(uri);

    try {
      var body = jsonDecode(response.body)['result']['records'][0];

      return CaseData.fromJson(body);
    } catch (e) {
      return e;
    }
  }
}
