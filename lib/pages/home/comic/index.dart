import 'package:flutter/material.dart';
import 'package:flutter_fly/router/application.dart';

import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_fly/router/route_animate.dart';

class Comic extends StatefulWidget {
  Comic({Key key}) : super(key: key);

  _ComicState createState() => _ComicState();
}

class _ComicState extends State<Comic> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
              child: Container(
                  alignment: Alignment.center,
                  child: Text('聊天', style: TextStyle(fontSize: 22))),
              onTap: () {
                Application.router.navigateTo(context, '/chat',
                    transition: TransitionType.cupertino);
              }),
          GestureDetector(
              child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  alignment: Alignment.center,
                  child: Text('单个列表', style: TextStyle(fontSize: 22))),
              onTap: () {
                Application.router.navigateTo(context, '/singleListDemo',
                    transition: TransitionType.cupertino);
              }),
          GestureDetector(
              child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  alignment: Alignment.center,
                  child: Text('tab列表', style: TextStyle(fontSize: 22))),
              onTap: () {
                Application.router.navigateTo(context, '/tabListDemo',
                    transition: TransitionType.cupertino);
              }),
          GestureDetector(
              child: Container(
                  alignment: Alignment.center,
                  child: Text('tab2列表', style: TextStyle(fontSize: 22))),
              onTap: () {
                Application.router.navigateTo(context, '/tabList2Demo',
                    transition: TransitionType.cupertino);
              }),
          GestureDetector(
              child: Container(
                  alignment: Alignment.center,
                  child: Text('tab3列表', style: TextStyle(fontSize: 22))),
              onTap: () {
                Application.router.navigateTo(context, '/tabList3Demo',
                    transition: TransitionType.cupertino);
              })
        ],
      ),
    );
  }
}
