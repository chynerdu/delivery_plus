import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HttpInstance {
  HttpInstance._();

  static final instance = HttpInstance._();

  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "charset": "utf-8",
    "x-auth-token": ""
  };

  Future getData({required String path}) async {
    try {
      Future<http.Response> apiResponse =
          http.get(Uri.parse(path), headers: headers);
      http.Response response = await apiResponse;

      print('response ${response.body}');

      return jsonDecode(response.body);
    } on SocketException catch (_) {
      throw 'Kindly, check your internet connection.';
    } on TimeoutException catch (_) {
      throw 'Request Timeout.';
    } on FormatException catch (_) {
      throw 'Error Occured.';
    } catch (e) {
      throw e;
    }
  }
}
