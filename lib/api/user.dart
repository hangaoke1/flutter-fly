import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_fly/models/index.dart';
import './index.dart';

// 用户登录
Future login(dynamic params) async {
  print('>>> 请求参数$params');
  Response response = await dio.post("/user/login", data: params);
  String jsonStr = json.encode(response.data);
  Map<String, dynamic> jsonObj = json.decode(jsonStr);
  String resData = jsonObj['data'];
  return resData;
}

// 获取用户信息
Future getUserInfo() async {
  Response response = await dio.get("/user/getUserInfo");
  String jsonStr = json.encode(response.data);
  Map<String, dynamic> jsonObj = json.decode(jsonStr);
  UserInfoHttp result = UserInfoHttp.fromJson(jsonObj);
  return result.data;
}
