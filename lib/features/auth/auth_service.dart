import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/network/dio_client.dart';

class AuthService {
  // final Dio _dio = buildDioClient(interceptors: []);
  // Coba buatan Farid
  final Dio _dio = Dio();

  final String baseUrl = "http://10.0.2.2:80/api/auth";
  Future<bool> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '$baseUrl/login',
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Host': 'majadigi.test',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData['status'] == true && responseData['token'] != null) {
          final prefs = await SharedPreferences.getInstance();

          String nameFromApi = responseData['user']['name'] ?? 'User Majadigi';
          String tokenFromApi = responseData['token'] ?? '';

          await prefs.setString('user_real_name', nameFromApi);
          await prefs.setString('auth_token', tokenFromApi);

          return true;
        }
      }
      return false;
    } on DioException catch (e) {
      print("======== DETAIL EROR API LARAVEL HERD ========");
      print("Status   Code: ${e.response?.statusCode}");
      print("Respon BE: ${e.response?.data}");
      print("Eror Tipe: ${e.type}");
      print("Pesan Kasar: ${e.message}");
      print("==============================================");

      // Lempar balik erornya ke UI biar nampil di Snackbar debug kita
      rethrow;
    } catch (e) {
      print("Eror Lainnya: $e");
      return false;
    }
  }
}