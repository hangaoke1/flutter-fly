import 'package:flutter/material.dart';

class NotFound extends StatefulWidget {
  NotFound({Key key}) : super(key: key);

  _NotFoundState createState() => _NotFoundState();
}

class _NotFoundState extends State<NotFound> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      child: Text('404页面不存在'),
    );
  }
}