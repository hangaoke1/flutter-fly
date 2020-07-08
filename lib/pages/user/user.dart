import 'package:fluro/fluro.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

import 'package:provider/provider.dart';
import 'package:flutter_fly/provider/user.dart';
import 'package:flutter_fly/router/application.dart';
import 'package:flutter_fly/router/route_animate.dart';
import 'package:flutter_fly/utils/theme.dart';

class User extends StatefulWidget {
  User({Key key}) : super(key: key);

  _UserState createState() => _UserState();
}

class _UserState extends State<User> with WidgetsBindingObserver {
  EasyRefreshController _controller = EasyRefreshController();
  DateTime nowDate = DateTime.now();

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

  _goSetting() {
    Application.router.navigateTo(context, '/setting',
        transition: TransitionType.custom, transitionBuilder: scaleAni);
  }

  rpx(double value) {
    return ScreenUtil.getInstance().getWidth(value);
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtil.isDark(context);
    Color primaryColor = Theme.of(context).primaryColor;
    Color cardColor = Theme.of(context).cardColor;
    Color scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    Color shawDowColor = isDark ? Color(0xFF000000) : Color(0xFFEEEEEE);
    TextStyle textStyle = Theme.of(context).textTheme.bodyText1;
    TextStyle subTextStyle = Theme.of(context).textTheme.subtitle1;

    return Container(
      decoration: BoxDecoration(color: scaffoldBackgroundColor),
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
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: rpx(30)),
                  child: Container(
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
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: rpx(30)),
                    padding: EdgeInsets.all(rpx(30)),
                    width: rpx(700),
                    height: rpx(200),
                    decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(rpx(10)),
                        boxShadow: [
                          BoxShadow(
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
          SliverList(
            delegate: SliverChildListDelegate(
              [
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
                      '${DateUtil.formatDate(nowDate, format: DateFormats.full)}',
                      style: textStyle,
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  margin: EdgeInsets.only(top: rpx(20), bottom: rpx(50)),
                  decoration: BoxDecoration(color: cardColor),
                  child: ListTile(
                    onTap: _goSetting,
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
                )
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: UnconstrainedBox(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 250.0, minWidth: 0),
                child: Container(
                  color: Colors.red,
                  child: Html(
                    data: """我是文字""",
                    shrinkWrap: true,
                    style: {
                      "html": Style(
                        display: Display.INLINE,
                        margin: EdgeInsets.all(0),
                      ),
                      "body": Style(
                        display: Display.INLINE,
                        margin: EdgeInsets.all(0),
                      ),
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
