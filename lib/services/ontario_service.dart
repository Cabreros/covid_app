import 'dart:convert';
import 'package:http/http.dart' as http;

class OntarioService {
  Future<dynamic> getCaseData([DateTime date]) async {
    Map<String, String> requestHeaders;

    if (date != null) {
      final now = DateTime.now();

      String day = now.day.toString();
      String month = now.month.toString();
      String year = now.year.toString();

      if (day.length == 1) {
        day = '0' + day;
      }
      if (month.length == 1) {
        month = '0' + month;
      }

      requestHeaders = {
        'resource_id': '8a88fe6d-d8fb-41a3-9d04-f0550a44999f',
        'q': year + '-' + month + '-' + day,
        'limit': '5',
      };
    } else {
      requestHeaders = {
        'resource_id': '8a88fe6d-d8fb-41a3-9d04-f0550a44999f',
        'limit': '5',
      };
    }

    final uri = Uri.https(
        'data.ontario.ca', '/api/3/action/datastore_search', requestHeaders);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body)['result']['records'];

      if (body.length < 1) {
        return null;
      } else {
        return body[0]['Total'];
      }
    } else {
      throw "unable to retrieve posts.";
    }
  }
}
