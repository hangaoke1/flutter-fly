import 'package:flutter/material.dart';
import 'package:flutter_fly/storage/index.dart';

import 'package:flutter_fly/router/application.dart';
class User extends StatefulWidget {
  User({Key key}) : super(key: key);

  _UserState createState() => _UserState();
}


class _UserState extends State<User> {

  _logout() {
    SpUtil.preferences.setString('TOKEN', null);
    Application.router.navigateTo(context, '/login', clearStack: true);
  }

  @override
  Widget build(BuildContext context) {
    // final double statusBarHeight = MediaQuery.of(context).padding.top;
    final listItem = ['用户名称', '用户账号', '用户等级', '可用余额'];
    List<Widget> listWidget = [];
    listItem.forEach((title) {
      listWidget.add(Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            print('--InkWell--');
          },
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black26,
                        width: 1.0,
                        style: BorderStyle.solid))),
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
                        child: Text('大哥老',
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
      child: ListView(children: [
        ...listWidget,
        Center(
          child: Container(
            width: 350,
            margin: EdgeInsets.only(top: 20),
            child: RaisedButton(
              padding: EdgeInsets.only(top: 15, bottom: 15),
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
      ]),
    );
  }
}
