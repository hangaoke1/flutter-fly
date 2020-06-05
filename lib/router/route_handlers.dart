import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:hello_world/pages/login/login.dart';
import 'package:hello_world/pages/user/user.dart';

import 'package:hello_world/pages/demo/sigleList.dart';
import 'package:hello_world/pages/demo/tabList.dart';
import 'package:hello_world/pages/demo/tabList2.dart';
import 'package:hello_world/pages/help/index.dart';
import 'package:hello_world/pages/notFound/index.dart';
import 'package:hello_world/pages/root/index.dart';
import 'package:hello_world/pages/movieDetail/index.dart';
import 'package:hello_world/storage/index.dart';

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

// 用户中心
var userHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return User();
});

// 主页面
var rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return checkLogin(Root());
});

// 电影详情
var movieDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params['id'].first;
  return MovieDetail(id: id);
});

// 帮助页面
var helpHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return Help();
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
