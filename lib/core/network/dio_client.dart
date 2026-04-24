import 'package:dio/dio.dart';

import '../constants/app_constants.dart';
import 'api_endpoints.dart';

Dio buildDioClient({required Iterable<Interceptor> interceptors}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: AppConstants.defaultConnectTimeout,
      receiveTimeout: AppConstants.defaultReceiveTimeout,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      headers: const {'Accept': Headers.jsonContentType},
    ),
  );

  dio.interceptors.addAll(interceptors);
  return dio;
}
