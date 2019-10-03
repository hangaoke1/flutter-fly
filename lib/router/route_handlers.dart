import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:hello_world/pages/about/index.dart';
import 'package:hello_world/pages/demo/sigleList.dart';
import 'package:hello_world/pages/demo/tabList.dart';
import 'package:hello_world/pages/demo/tabList2.dart';
import 'package:hello_world/pages/help/index.dart';
import 'package:hello_world/pages/notFount/index.dart';

import 'package:hello_world/pages/root/index.dart';
import 'package:hello_world/pages/movieDetail/index.dart';

// 跟页面
var rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return Root();
});

// 电影详情
var movieDetailHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params['id'].first;
  return MovieDetail(id: id);
});

// 关于
var aboutHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return About();
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
