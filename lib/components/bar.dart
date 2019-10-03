import 'package:flutter/material.dart';
import 'package:hello_world/utils/eventbus.dart';

class Bar extends StatefulWidget {
  Bar({Key key}) : super(key: key);

  _BarState createState() => _BarState();
}

class _BarState extends State<Bar> {
  @override
  void initState() {
    super.initState();
    eventbus.on('login', (arg) {
      print('bar收到通知');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text('Bar 233'),
    );
  }
}