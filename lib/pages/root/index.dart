import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/pages/home/index.dart';
import 'package:hello_world/pages/hot/index.dart';
import 'package:hello_world/pages/user/index.dart';
import 'package:hello_world/pages/test/index.dart';

class Root extends StatefulWidget {
  Root({Key key}) : super(key: key);

  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  int _tabIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  
  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('提示'),
        content: new Text('客官，确定退出app?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('放弃'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('退出'),
          ),
        ],
      ),
    ) ?? false;
  }

  void _onItemTapped(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: IndexedStack(
          children: <Widget>[
            Test(),
            Home(),
            Hot(),
            User(),
          ],
          index: _tabIndex,
        ),
        bottomNavigationBar: CurvedNavigationBar( // 底部导航
          key: _bottomNavigationKey,
          items: <Widget  >[
            Icon(Icons.list, size: 30),
            Icon(Icons.home, size: 30),
            Icon(Icons.business, size: 30),
            Icon(Icons.school, size: 30)
          ],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}