import 'package:flutter/material.dart';
import 'package:hello_world/pages/demo/list.dart';

class SingleListDemo extends StatefulWidget {
  SingleListDemo({Key key}) : super(key: key);

  _SingleListDemoState createState() => _SingleListDemoState();
}

class _SingleListDemoState extends State<SingleListDemo> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('列表加载demo'), elevation: 0.5),
      body: ListWrap()
    );
  }
}
