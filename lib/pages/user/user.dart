import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:day/day.dart';
import 'package:flutter_fly/provider/user.dart';
import 'package:flutter_fly/storage/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_fly/router/application.dart';

import 'package:provider/provider.dart';

class User extends StatefulWidget {
  User({Key key}) : super(key: key);

  _UserState createState() => _UserState();
}

class _UserState extends State<User> with WidgetsBindingObserver {
  EasyRefreshController _controller = EasyRefreshController();
  Day nowDate = Day();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); //添加观察者
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    var a = ModalRoute.of(context);
    print('是否是顶层路由${a.isCurrent}');
    print("lifeChanged $state");
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this); //销毁
  }

  _logout() {
    SpUtil.preferences.setString('TOKEN', null);
    Application.router.navigateTo(context, '/login', clearStack: true);
  }

  @override
  Widget build(BuildContext context) {
    // final double statusBarHeight = MediaQuery.of(context).padding.top;
    TextStyle textFontStyle = TextStyle(fontSize: 20, color: Colors.black);

    final listItem = ['用户名称', '用户账号', '用户等级', '可用余额'];
    List<Widget> listWidget = [];
    listItem.asMap().forEach((index, title) {
      listWidget.add(Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            print('--InkWell--');
          },
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: index != listItem.length - 1
                  ? Border(
                      bottom: BorderSide(
                          color: Colors.black26,
                          width: 0.5,
                          style: BorderStyle.solid),
                    )
                  : null,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Container(
                      width: 150,
                      child: Text(
                        title,
                        style:
                            TextStyle(color: Color(0xFF000000), fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                        child: Text(context.watch<UserProvider>().user.username,
                            style: TextStyle(
                                color: Color(0xFF666666), fontSize: 16),
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis)),
                  )
                ]),
          ),
        ),
      ));
    });

    return Container(
      decoration: BoxDecoration(color: Color(0xFFEEEEEE)),
      child: EasyRefresh.custom(
        header: BallPulseHeader(color: Theme.of(context).primaryColor),
        controller: _controller,
        onRefresh: () async {
          await Future.delayed(Duration(milliseconds: 1000));
          await context.read<UserProvider>().setUser();
          _controller.finishRefresh();
        },
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(top: ScreenUtil().setWidth(100)),
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.network(
                              "https://pcdn.flutterchina.club/imgs/3-17.png",
                              width: ScreenUtil().setWidth(200),
                            ),
                            Text('小神通'),
                          ],
                        ),
                        Icon(
                          IconData(0xe605, fontFamily: 'Iconfont'),
                          size: 20.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Stack(
              alignment: Alignment.center,
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: ScreenUtil().setWidth(200),
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  padding: EdgeInsets.all(30),
                  width: ScreenUtil().setWidth(700),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(3, 3),
                            color: Color(0xffCCCCCC),
                            blurRadius: 10.0,
                            spreadRadius: 0.5),
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Icon(Icons.face, color: Colors.orange),
                            margin: EdgeInsets.only(bottom: 10),
                          ),
                          Text('充值')
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Icon(Icons.face, color: Colors.yellow),
                            margin: EdgeInsets.only(bottom: 10),
                          ),
                          Text('提现')
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Icon(Icons.face, color: Colors.red),
                            margin: EdgeInsets.only(bottom: 10),
                          ),
                          Text('转存')
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
                decoration: BoxDecoration(color: Colors.white),
                child: ListTile(
                  leading: Icon(
                    IconData(0xe65a, fontFamily: 'Iconfont'),
                    size: 20.0,
                  ),
                  title: Text('用户名称'),
                  trailing: Container(
                    width: 200,
                    child: Text(
                      '${context.watch<UserProvider>().user.username}',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: textFontStyle,
                    ),
                  ),
                )),
            Divider(
              height: 1,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: ListTile(
                leading: Icon(Icons.phone_iphone),
                title: Text('手机号'),
                trailing: Text(
                  '${context.watch<UserProvider>().user.phone}',
                  style: textFontStyle,
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: ListTile(
                leading: Icon(Icons.face),
                title: Text('用户等级'),
                trailing: Text(
                  '${context.watch<UserProvider>().user.userLevel}',
                  style: textFontStyle,
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: ListTile(
                leading: Icon(
                  IconData(0xe66c, fontFamily: 'Iconfont'),
                  size: 20.0,
                ),
                title: Text('可用余额'),
                trailing: Text(
                  '${context.watch<UserProvider>().user.balance / 100}',
                  style: textFontStyle,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: ListTile(
                leading: Icon(
                  IconData(0xe6bc, fontFamily: 'Iconfont'),
                  size: 20.0,
                ),
                title: Text('注册日期'),
                trailing: Text(
                  '${nowDate.format("YYYY-MM-DD")}',
                  style: textFontStyle,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: ListTile(
                leading: Icon(
                  IconData(0xe6e4, fontFamily: 'Iconfont'),
                  size: 20.0,
                ),
                title: Text('版本号'),
                trailing: Text(
                  'V 1.0.0',
                  style: textFontStyle,
                ),
              ),
            ),
            Center(
              child: Container(
                width: ScreenUtil().setWidth(500),
                margin: EdgeInsets.only(
                    top: ScreenUtil().setWidth(40), bottom: 100),
                child: RaisedButton(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setWidth(20),
                      bottom: ScreenUtil().setWidth(20)),
                  color: Color(0xFFf5222d),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    '退出登录',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: _logout,
                ),
              ),
            )
          ]))
        ],
      ),
    );
  }
}
