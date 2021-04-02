import 'dart:convert';

import 'package:current_cases_app/services/summary_model.dart';
import 'package:http/http.dart' as http;

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
}
