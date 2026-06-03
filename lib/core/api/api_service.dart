import 'dart:convert';
import 'package:http/http.dart' as http;
import '../storage/auth_storage.dart';

class ApiService {
  static const String baseUrl = 'https://341f-103-171-162-159.ngrok-free.app/api';

  static Future<http.Response> get(String endpoint) async {
    final token = await AuthStorage.getToken();

    return await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': 'true',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
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
      },
      body: jsonEncode(body),
    );
  }
}