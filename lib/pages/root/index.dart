import 'package:flutter/material.dart';
import 'package:flutter_fly/app.dart';
import 'package:flutter_fly/provider/user.dart';

import 'package:flutter_fly/pages/home/index.dart';
import 'package:flutter_fly/pages/user/user.dart';
import 'package:flutter_fly/pages/find/index.dart';
import 'package:flutter_fly/pages/test/index.dart';

import 'package:provider/provider.dart';
class Root extends StatefulWidget {
  Root({Key key}) : super(key: key);

  _RootState createState() => _RootState();
}

class _RootState extends State<Root> with RouteAware {
  int _tabIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  void didChangeDependencies() {
    AppComponent.routeObserver.subscribe(this, ModalRoute.of(context)); //订阅
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    AppComponent.routeObserver.unsubscribe(this); //取消订阅
    super.dispose();
  }

  @override
  void didPopNext() {
    // 返回页面
    print('返回页面root');
  }

  @override
  void didPush() async{
    // 首次进入
    await context.read<UserProvider>().setUser();
    print('进入页面root');
  }

  @override
  void didPushNext() {
    // 离开页面
    print('离开页面root');
  }

  @override
  void didPop() {
    print('>>> didPop');
  }

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
            Home(),
            Test(),
            Find(),
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
                icon: Icon(Icons.favorite, size: 30), title: Text('发现')),
            new BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, size: 30),
                title: Text('个人中心')),
          ],
        ),
      ),
    );
  }
}
