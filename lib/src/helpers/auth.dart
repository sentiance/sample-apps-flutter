import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthCodeResult {
  final String authCode;
  final String appId;

  AuthCodeResult(this.authCode, this.appId);
}

Future<AuthCodeResult> fetchAuthCode() async {
  final response = await http.get(Uri.parse('http://localhost:8000/auth/code'));

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON.
    final Map<String, dynamic> data = json.decode(response.body);
    return AuthCodeResult(data['auth_code'], data['app_id']);
  } else {
    // If the server returns an unsuccessful response code, throw an exception.
    throw Exception('Failed to load data');
  }
}
