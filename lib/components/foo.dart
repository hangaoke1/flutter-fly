import 'package:flutter/material.dart';
import 'package:flutter_fly/utils/eventbus.dart';

class Foo extends StatefulWidget {
  Foo({Key key}) : super(key: key);

  _FooState createState() => _FooState();
}

class _FooState extends State<Foo> {
  @override
  void initState() {
    super.initState();
    eventbus.on('login', (arg) {
      print('foo收到通知');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text('Foo'),
    );
  }
}
