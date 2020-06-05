import 'package:dio/dio.dart';

// dio拦截器
class CustomInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    print(">>> 请求拦截[${options?.method}] => PATH: ${options?.path}");
    return super.onRequest(options);
  }
  @override
  Future onResponse(Response response) {
    print(">>> 响应拦截[${response?.statusCode}] => PATH: ${response?.request?.path}");
    return super.onResponse(response);
  }
  @override
  Future onError(DioError err) {
    print(">>> ERROR[${err?.response?.statusCode}] => PATH: ${err?.request?.path}");
    return super.onError(err);
  }
}
