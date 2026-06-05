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

  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String nik,
    required String birthDate,
    required String password,
    required String passwordConfirmation,
  }) async {
    final response = await ApiService.post(
      '/auth/register',
      {
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'nik': nik,
        'birth_date': birthDate,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 ||
        response.statusCode == 201) {
      return data;
    }

    throw Exception(
      data['message'] ?? 'Registrasi gagal',
    );
  }

}
