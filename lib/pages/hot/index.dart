import 'package:flutter/material.dart';

class Hot extends StatefulWidget {
  Hot({Key key}) : super(key: key);

  _HotState createState() => _HotState();
}

class _HotState extends State<Hot> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      child: Text('热门'),
    );
  }
}