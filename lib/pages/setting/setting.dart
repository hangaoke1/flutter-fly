import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fly/constant/constant.dart';
import 'package:flutter_fly/provider/theme.dart';
import 'package:flutter_fly/router/application.dart';
import 'package:flutter_fly/theme/colours.dart';
import 'package:flutter_fly/utils/theme.dart';
import 'package:package_info/package_info.dart';

import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  PackageInfo _packageInfo = PackageInfo(
    appName: '-',
    packageName: '-',
    version: '-',
    buildNumber: '-',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  // 退出登录
  _logout() {
    SpUtil.putString(Constant.accessToken, null);
    Application.router.navigateTo(context, '/login', clearStack: true);
  }

  _changeTheme() {
    ThemeMode mode = context.read<ThemeProvider>().getThemeMode();
    if (mode == ThemeMode.dark) {
      context.read<ThemeProvider>().setTheme(ThemeMode.light);
    } else {
      context.read<ThemeProvider>().setTheme(ThemeMode.dark);
    }
  }

  rpx(double value) {
    return ScreenUtil.getInstance().getWidth(value);
  }

  Widget _infoTile(
      {String title, Widget leading, Widget trailing, Function onTap}) {
    Color cardColor = Theme.of(context).cardColor;
    return Container(
      margin: EdgeInsets.only(bottom: rpx(20)),
      decoration: BoxDecoration(color: cardColor),
      child: ListTile(
        onTap: onTap,
        leading: leading,
        title: Text(title),
        trailing: trailing,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtil.isDark(context);
    Color primaryColor = Theme.of(context).primaryColor;
    TextStyle textStyle = Theme.of(context).textTheme.bodyText1;

    return Scaffold(
      appBar: AppBar(title: Text('设置中心'), elevation: 0.5),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _infoTile(
              onTap: _changeTheme,
              title: '主题切换',
              leading: Icon(
                IconData(0xe66f, fontFamily: 'Iconfont'),
                size: 20.0,
              ),
              trailing: Text(SpUtil.getString(Constant.theme)),
            ),
            _infoTile(
              title: '版本号',
              leading: Icon(
                IconData(0xe6e4, fontFamily: 'Iconfont'),
                size: 20.0,
              ),
              trailing: Text(_packageInfo.version, style: textStyle),
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
                      color: isDark ? Colours.dark_button_text : Colors.white,
                    ),
                  ),
                  onPressed: _logout,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
