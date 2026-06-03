import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static Future<String?> getToken() async {
    return "10|XeFUMr1VPpY1o4c0tUoomgelt019ctWdwXf1ur6a0b4a1611"; // TEMP
  }
// static Future<void> saveToken(String token) async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString('token', token);
// }
//
// static Future<String?> getToken() async {
//   final prefs = await SharedPreferences.getInstance();
//   return prefs.getString('token');
// }
}