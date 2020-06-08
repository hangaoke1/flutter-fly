import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_fly/models/index.dart';
import './index.dart';

// 获取订单列表
Future queryOrderList(dynamic params) async {
  print('>>> 请求参数$params');
   Response response =
        await dio.get("http://110.80.137.93:3000/mock/200/order/list");
    String jsonStr = json.encode(response.data);
    Map<String, dynamic> jsonObj = json.decode(jsonStr);
    OrderListHttp result = OrderListHttp.fromJson(jsonObj);
    List<Order> orderList = result.data;
  return orderList;
}
