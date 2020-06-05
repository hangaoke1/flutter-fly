import 'package:flutter/material.dart';

import 'package:flutter_fly/pages/user/user.dart';
import 'package:flutter_fly/pages/home/index.dart';
import 'package:flutter_fly/pages/hot/index.dart';
import 'package:flutter_fly/pages/test/index.dart';

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
        ) ??
        false;
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
        bottomNavigationBar: BottomNavigationBar(
          key: _bottomNavigationKey,
          onTap: _onItemTapped,
          currentIndex: _tabIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            new BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30), title: Text('首页')),
            new BottomNavigationBarItem(
                icon: Icon(Icons.view_list, size: 30), title: Text('列表')),
            new BottomNavigationBarItem(
                icon: Icon(Icons.favorite, size: 30), title: Text('测试')),
            new BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, size: 30), title: Text('个人中心')),
          ],
        ),
        // bottomNavigationBar: CurvedNavigationBar( // 底部导航
        //   key: _bottomNavigationKey,
        //   items: <Widget  >[
        //     Icon(Icons.list, size: 30),
        //     Icon(Icons.home, size: 30),
        //     Icon(Icons.business, size: 30),
        //     Icon(Icons.school, size: 30)
        //   ],
        //   onTap: _onItemTapped,
        // ),
      ),
    );
  }
}
