import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../../injection_container.dart';

class DioInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final prefs = getIt.get<SharedPreferences>();
    final token = prefs.getString('token');
    final userId = prefs.getString('id');
    final userName = prefs.getString('name');

    options.headers['X-Secret-Token'] = secret;

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
      options.headers['member-id'] = userId;
      options.headers['user-login-name'] = userName;
      options.headers['is-mobile'] = true;
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);
  }
}
