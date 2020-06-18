import 'package:flutter/material.dart';

class Find extends StatefulWidget {
  Find({Key key}) : super(key: key);

  _FindState createState() => _FindState();
}

class _FindState extends State<Find> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      child: Text('热门'),
    );
  }
}