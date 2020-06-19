import 'package:flustars/flustars.dart';
import 'package:day/day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_fly/constant/constant.dart';
import 'package:flutter_fly/provider/theme.dart';
import 'package:flutter_fly/provider/user.dart';

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
    SpUtil.putString(Constant.accessToken, null);
    Application.router.navigateTo(context, '/login', clearStack: true);
  }

  rpx(double value) {
    return ScreenUtil.getInstance().getWidth(value);
  }

  @override
  Widget build(BuildContext context) {

    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color primaryColor = Theme.of(context).primaryColor;
    Color cardColor = Theme.of(context).cardColor;
    Color bgColor = Theme.of(context).scaffoldBackgroundColor;
    Color shawDowColor = isDark ? Color(0xFF000000) : Color(0xFFEEEEEE);
    TextStyle textStyle = Theme.of(context).textTheme.bodyText1;
    TextStyle subTextStyle = Theme.of(context).textTheme.subtitle1;

    return Container(
      decoration: BoxDecoration(color: bgColor),
      child: EasyRefresh.custom(
        header: BallPulseHeader(color: primaryColor),
        controller: _controller,
        onRefresh: () async {
          await Future.delayed(Duration(milliseconds: 1000));
          await context.read<UserProvider>().setUser();
          _controller.finishRefresh();
        },
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(bottom: rpx(200)),
              child: Stack(
                alignment: Alignment.center,
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      top: rpx(100),
                      bottom: rpx(50),
                      left: rpx(20),
                      right: rpx(20),
                    ),
                    decoration: BoxDecoration(
                      color: cardColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: <Widget>[
                              ClipRRect(
                                //剪裁为圆角矩形
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image.network(
                                  "https://pcdn.flutterchina.club/imgs/3-17.png",
                                  width: rpx(150),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: rpx(20), right: rpx(20)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '${context.watch<UserProvider>().user.username}',
                                        style: textStyle.copyWith(fontSize: 24),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        '暂无简介',
                                        style: subTextStyle,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          IconData(0xe65b, fontFamily: 'Iconfont'),
                          size: 35.0,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: rpx(-180),
                    child: Container(
                      padding: EdgeInsets.all(rpx(30)),
                      width: rpx(700),
                      height: rpx(200),
                      decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(rpx(10)),
                          boxShadow: [
                            BoxShadow(
                              // offset: Offset(-3, -3),
                              color: shawDowColor,
                              blurRadius: 10.0,
                              spreadRadius: 0.5,
                            ),
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
                                margin: EdgeInsets.only(bottom: rpx(10)),
                              ),
                              Text('充值')
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Icon(Icons.face, color: Colors.yellow),
                                margin: EdgeInsets.only(bottom: rpx(10)),
                              ),
                              Text('提现')
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Icon(Icons.face, color: Colors.red),
                                margin: EdgeInsets.only(bottom: rpx(10)),
                              ),
                              Text('转存')
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Material(
                  color: cardColor,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                        child: ListTile(
                      leading: Icon(
                        IconData(0xe65a, fontFamily: 'Iconfont'),
                        size: 20.0,
                      ),
                      title: Text('用户名称'),
                      trailing: Container(
                        width: rpx(400),
                        child: Text(
                          '${context.watch<UserProvider>().user.username}',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                          style: textStyle,
                        ),
                      ),
                    )),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  decoration: BoxDecoration(color: cardColor),
                  child: ListTile(
                    leading: Icon(Icons.phone_iphone),
                    title: Text('手机号'),
                    trailing: Text(
                      '${context.watch<UserProvider>().user.phone}',
                      style: textStyle,
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  decoration: BoxDecoration(color: cardColor),
                  child: ListTile(
                    leading: Icon(Icons.face),
                    title: Text('用户等级'),
                    trailing: Text(
                      '${context.watch<UserProvider>().user.userLevel}',
                      style: textStyle,
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  decoration: BoxDecoration(color: cardColor),
                  child: ListTile(
                    leading: Icon(
                      IconData(0xe66c, fontFamily: 'Iconfont'),
                      size: 20.0,
                    ),
                    title: Text('可用余额'),
                    trailing: Text(
                      '${context.watch<UserProvider>().user.balance / 100}',
                      style: textStyle,
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  decoration: BoxDecoration(color: cardColor),
                  child: ListTile(
                    leading: Icon(
                      IconData(0xe6bc, fontFamily: 'Iconfont'),
                      size: 20.0,
                    ),
                    title: Text('注册日期'),
                    trailing: Text(
                      '${nowDate.format("YYYY-MM-DD")}',
                      style: textStyle,
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  decoration: BoxDecoration(color: cardColor),
                  child: ListTile(
                    leading: Icon(
                      IconData(0xe6e4, fontFamily: 'Iconfont'),
                      size: 20.0,
                    ),
                    title: Text('版本号'),
                    trailing: Text('V 1.0.0', style: textStyle),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: rpx(20)),
                  decoration: BoxDecoration(color: cardColor),
                  child: ListTile(
                    onTap: () {
                      ThemeMode mode =
                          context.read<ThemeProvider>().getThemeMode();
                      if (mode == ThemeMode.dark) {
                        context.read<ThemeProvider>().setTheme(ThemeMode.light);
                      } else {
                        context.read<ThemeProvider>().setTheme(ThemeMode.dark);
                      }
                    },
                    leading: Icon(
                      IconData(0xe66f, fontFamily: 'Iconfont'),
                      size: 20.0,
                    ),
                    title: Text('主题切换'),
                    trailing: Text(SpUtil.getString(Constant.theme)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: rpx(20)),
                  decoration: BoxDecoration(color: cardColor),
                  child: ListTile(
                    leading: Icon(
                      IconData(0xe68f, fontFamily: 'Iconfont'),
                      size: 20.0,
                    ),
                    title: Text('设置'),
                    trailing: Icon(
                      IconData(0xe60d, fontFamily: 'Iconfont'),
                      size: 20.0,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: rpx(420),
                    margin: EdgeInsets.only(top: rpx(40), bottom: rpx(100)),
                    child: RaisedButton(
                      padding: EdgeInsets.only(top: rpx(20), bottom: rpx(20)),
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(rpx(10)),
                      ),
                      child: Text(
                        '退出登录',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: _logout,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
