import 'dart:convert';
import 'package:http/http.dart' as http;
import '../storage/auth_storage.dart';

class ApiService {
  // static const String baseUrl = 'https://capstone-project-majadigi-to-super-app-production.up.railway.app/api';
    static const String baseUrl = 'http://10.0.2.2/api';
  static Future<http.Response> get(String endpoint) async {
    final token = await AuthStorage.getToken();

    print("==== CEK TOKEN KETENAGAKERJAAN: $token ====");

    return await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': 'true',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Host': 'majadigi.test',
      },
    );
  }

  static Future<http.Response> post(String endpoint, Map body) async {
    final token = await AuthStorage.getToken();

    return await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Host': 'majadigi.test',
      },
      body: jsonEncode(body),
    );
  }
}