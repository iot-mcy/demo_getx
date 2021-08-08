import 'package:dio/dio.dart';

import '../api.dart';

/// 作者 mcy
/// 时间 2021/7/26 15:00
/// 请求头拦截器
class HeaderInterceptors extends Interceptor {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.baseUrl = HttpManager.URL;
    options.connectTimeout = 30000;
    return super.onRequest(options, handler);
  }
}
