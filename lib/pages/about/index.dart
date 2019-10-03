import 'package:flutter/material.dart';

class About extends StatefulWidget {
  About({Key key}) : super(key: key);

  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('关于我们'), elevation: 0.5),
      body: Center(
        child: Container(
          child: Text('关于'),
        ),
      ),
    );
  }
}
