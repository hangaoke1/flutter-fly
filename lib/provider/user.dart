import 'package:flutter/material.dart';
import 'package:flutter_fly/models/index.dart';
import 'package:flutter_fly/api/user.dart' as userApi;

class UserProvider extends ChangeNotifier {
  UserInfo _user = UserInfo.fromJson({
    "userId": "-",
    "username": "游客",
    "phone": "-",
    "userLevel": 1,
    "balance": 0,
    "userStatus": 1,
    "hasNameAuth": false
  });
  UserInfo get user => _user;

  Future setUser() async {
    UserInfo user = await userApi.getUserInfo();
    if (user != null) {
      _user = user;
      notifyListeners();
    }
  }

  void setUserName(String username) {
    _user.username = username;
    notifyListeners();
  }
}
