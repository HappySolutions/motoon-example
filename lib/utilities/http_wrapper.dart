import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:motoon_api_example/models/http_error.dart';

class HttpWrapper {
  Future<String> get(String url, {Map<String, String>? headers}) async {
    var uri = Uri.parse(url);
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw HttpError(statusCode: response.statusCode, response: response.body);
    }
  }

  Future<String> post(String url,
      {Map<String, String>? headers, Object? body}) async {
    var uri = Uri.parse(url);
    http.Response response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
      throw HttpError(statusCode: response.statusCode, response: response.body);
    }
  }

  Future put() async {}
  Future delete() async {}
  Future patch() async {}
}
