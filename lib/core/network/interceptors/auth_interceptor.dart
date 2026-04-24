import 'package:dio/dio.dart';

import '../../storage/shared_prefs_service.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._storage);

  final SharedPreferencesService _storage;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _storage.authToken;

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}
