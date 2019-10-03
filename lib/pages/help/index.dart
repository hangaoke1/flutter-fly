import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  Help({Key key}) : super(key: key);

  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('帮助中心'), elevation: 0.5),
      body: Center(
        child: Container(
          child: Text('帮助'),
        ),
      ),
    );
  }
}
