import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthCodeResult {
  final String authCode;
  final String appId;

  AuthCodeResult(this.authCode, this.appId);
}

Future<AuthCodeResult> fetchAuthCode() async {
  final response = await http.get(Uri.parse('http://localhost:8001/auth/code'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    return AuthCodeResult(data['auth_code'], data['app_id']);
  } else {
    throw Exception('Failed to load data');
  }
}
