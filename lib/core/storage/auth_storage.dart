import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static Future<String?> getToken() async {
    return "7|3AXRxjGEYon7JpQhDUlaOMube1EwQMJZVlytQrMz7a0659d8"; // TEMP
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