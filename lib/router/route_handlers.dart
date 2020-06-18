import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:flutter_fly/pages/login/login.dart';
import 'package:flutter_fly/pages/user/user.dart';

import 'package:flutter_fly/pages/demo/sigleList.dart';
import 'package:flutter_fly/pages/demo/tabList.dart';
import 'package:flutter_fly/pages/demo/tabList2.dart';
import 'package:flutter_fly/pages/demo/tabList3.dart';
import 'package:flutter_fly/pages/notFound/index.dart';
import 'package:flutter_fly/pages/root/index.dart';
import 'package:flutter_fly/pages/movieDetail/index.dart';
import 'package:flutter_fly/storage/index.dart';

Widget checkLogin(Widget page) {
  String token = SpUtil.preferences.getString('TOKEN');
  print('>>> 用户登录状态token: $token');
  if (token != null) {
    return page;
  } else {
    return Login();
  }
}

// 登录页面
var loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return Login();
});

// 主页面
var rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return checkLogin(Root());
});

// 用户中心
var userHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return User();
});

// 电影详情
var movieDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params['id'].first;
  return MovieDetail(id: id);
});

// 404
var notFoundHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return NotFound();
});

// 单个列表demo
var singleListDemoHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SingleListDemo();
});

// 多个列表demo
var tabListDemoHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TabListDemo();
});

var tabList2DemoHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TabList2Demo();
});

var tabList3DemoHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TabList3Demo();
});
