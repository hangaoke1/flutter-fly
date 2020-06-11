import 'dart:async';

import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:flutter_fly/router/application.dart';
import 'package:flutter_fly/storage/index.dart';
import 'package:flutter_fly/utils/fly.dart';

// dio拦截器
class CustomInterceptors extends InterceptorsWrapper {
  static Timer timer;

  @override
  Future onRequest(RequestOptions options) {
    print(">>> 请求拦截[${options?.method}] => PATH: ${options?.path}");
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    print(
        ">>> 响应拦截[${response?.statusCode}] => PATH: ${response?.request?.path}");
    String jsonStr = json.encode(response.data);
    Map<String, dynamic> jsonObj = json.decode(jsonStr);
    if (response?.statusCode != 200) {
      showText(text: '服务器异常');
    }
    if (jsonObj["code"] == -100) {
      if (CustomInterceptors.timer == null) {
        showText(text: '登录状态已过期');
        CustomInterceptors.timer = new Timer(new Duration(seconds: 2), () {
          CustomInterceptors.timer = null;
          SpUtil.preferences.setString('TOKEN', null);
          Application.navigatorKey.currentState
              .pushNamedAndRemoveUntil('/login', (route) => false);
        });
      } else {
        print("已经设定重定向登录拦截器！");
      }
    }
    if (jsonObj["code"] != 200) {
      showText(text: '${jsonObj['errmsg']}');
    }
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    print(
        ">>> ERROR[${err?.response?.statusCode}] => PATH: ${err?.request?.path}");
    return super.onError(err);
  }
}
