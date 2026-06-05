import 'dart:convert';

import '../../../core/api/api_service.dart';
import '../../../core/storage/auth_storage.dart';
import '../models/user_model.dart';

class AuthService {
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await ApiService.post('/auth/login', {
      'email': email,
      'password': password,
    });

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      await AuthStorage.saveToken(data['token']);

      return data;
    }

    throw Exception(data['message'] ?? 'Login gagal');
  }

  static Future<UserModel> me() async {
    final response = await ApiService.get('/auth/me');

    final data = jsonDecode(response.body);

    return UserModel.fromJson(data['data']);
  }

  static Future<void> logout() async {
    await AuthStorage.clear();
  }
}
