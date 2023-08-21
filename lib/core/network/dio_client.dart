import 'package:dio/dio.dart';

import '../constants/constants.dart';
import 'dio_interceptor.dart';

Dio buildDioClient() {
  final dio = Dio()..options = BaseOptions(baseUrl: apiBaseUrl);

  dio.interceptors.add(DioInterceptor());

  return dio;
}
