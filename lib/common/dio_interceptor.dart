import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');

    // Example: Add authorization token to headers
    options.headers.addAll({
      'Authorization': 'Bearer your_token_here',
      'Content-Type': 'application/json',
    });

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('RESPONSE[${response.statusCode}] => DATA: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('ERROR[${err.response?.statusCode}] => MESSAGE: ${err.message}');

    // Retry the request if it fails
    if (err.response?.statusCode == 401) {
      // Handle token refresh logic here
    }

    super.onError(err, handler);
  }
}
