import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/dio_client.dart';
import '../network/interceptors/auth_interceptor.dart';
import '../storage/shared_prefs_service.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden during bootstrap.',
  );
});

final sharedPreferencesServiceProvider = Provider<SharedPreferencesService>((
  ref,
) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return SharedPreferencesService(sharedPreferences);
});

final dioProvider = Provider<Dio>((ref) {
  final storage = ref.watch(sharedPreferencesServiceProvider);

  return buildDioClient(interceptors: [AuthInterceptor(storage)]);
});
