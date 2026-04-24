import 'package:shared_preferences/shared_preferences.dart';

import 'storage_keys.dart';

class SharedPreferencesService {
  SharedPreferencesService(this._preferences);

  final SharedPreferences _preferences;

  String? getString(String key) => _preferences.getString(key);

  Future<bool> setString(String key, String value) {
    return _preferences.setString(key, value);
  }

  int? getInt(String key) => _preferences.getInt(key);

  Future<bool> setInt(String key, int value) {
    return _preferences.setInt(key, value);
  }

  String? get authToken => getString(StorageKeys.authToken);

  Future<bool> setAuthToken(String token) {
    return setString(StorageKeys.authToken, token);
  }

  int get launchCount => getInt(StorageKeys.launchCount) ?? 0;

  Future<bool> setLaunchCount(int value) {
    return setInt(StorageKeys.launchCount, value);
  }

  Future<bool> clearSession() => _preferences.remove(StorageKeys.authToken);
}
