import 'dart:async';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_fly/constant/constant.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_fly/router/application.dart';
import 'package:flutter_fly/api/user.dart' as userApi;
import 'package:flutter_fly/utils/fly.dart' as fly;

class Login extends StatefulWidget {
  const Login();
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // 表单key
  GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  // 声明视频控制器
  VideoPlayerController _controller;
  // 视频地址
  final String videoUrl = "https://hgkcdn.oss-cn-shanghai.aliyuncs.com/image/5d6a7c25ba18b.mp4";
      // "https://video.pearvideo.com/mp4/third/20190730/cont-1584187-10136163-164150-hd.mp4";
  String username;
  String password;

  @override
  void initState() {
    super.initState();
    this._initVideo();
  }

  @override
  void dispose() {
    // 关闭所有
    fly.cleanAll();
    if (_controller != null) {
      _controller.pause();
    }
    super.dispose();
  }

  Future _initVideo() async {
    // var file = await DefaultCacheManager().getSingleFile(videoUrl);
    var cacheFile = await DefaultCacheManager().getFileFromCache(videoUrl);
    if (cacheFile != null && cacheFile.file != null) {
      print('>>> 从缓存中读取视频');
      _controller = VideoPlayerController.file(cacheFile.file)
        ..initialize().then((_) {
          setState(() {});
          _controller.play();
          _controller.setLooping(true);
          // _controller.setVolume(0.0);
          Timer.periodic(Duration(seconds: 15), (Timer time) {
            // print(time);
          });
        });
    } else {
      print('>>> 从网络中读取视频');
      _controller = VideoPlayerController.network(videoUrl)
        ..initialize().then((_) {
          setState(() {});
          _controller.play();
          _controller.setLooping(true);
          // _controller.setVolume(0.0);
          Timer.periodic(Duration(seconds: 15), (Timer time) {
            // print(time);
          });
        });
      DefaultCacheManager().downloadFile(videoUrl);
    }
  }

  Future _handleLogin() async {
    var _form = _loginKey.currentState;
    if (_form.validate()) {
      _form.save();
      dynamic params = {"username": username, "password": password};
      var close = fly.showLoading(text: "登录中...");
      try {
        await Future.delayed(Duration(milliseconds: 1000));
        String token = await userApi.login(params);
        close();
        fly.showText(text: "登录成功");
        await Future.delayed(Duration(milliseconds: 1000));
        print('登录成功 >>> $token');
        SpUtil.putString(Constant.accessToken, token);
        Application.router.navigateTo(context, '/', clearStack: true);
      } catch (err) {}
    } else {
      fly.showText(text: "账号/密码不能为空");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              _controller != null && _controller.value.initialized
                  ? Transform.scale(
                      scale: _controller.value.aspectRatio /
                          MediaQuery.of(context).size.aspectRatio *
                          1.01,
                      child: Center(
                        child: Container(
                            child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )),
                      ),
                    )
                  : Positioned(
                      child: Container(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        child: Text(''),
                      ),
                    ),
              Positioned(
                width: MediaQuery.of(context).size.width,
                top: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "登录",
                      style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "视频背景登录页面",
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: ScreenUtil().getWidthPx(650),
                      child: Form(
                          key: _loginKey,
                          autovalidate: false,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                                decoration: InputDecoration(
                                  enabledBorder: new UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: new UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  labelText: '账号',
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                  hintText: "手机号或用户名",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                                //校验用户
                                validator: (value) {
                                  return value.trim().length > 0
                                      ? null
                                      : "用户名不能为空";
                                },
                                //当 Form 表单调用保存方法 Save时回调的函数。
                                onSaved: (value) {
                                  username = value;
                                },
                                // 当用户确定已经完成编辑时触发
                                onFieldSubmitted: (value) {},
                              ),
                              TextFormField(
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                                decoration: InputDecoration(
                                  enabledBorder: new UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: new UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  labelText: '密码',
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                  hintText: '您的登录密码',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                ),
                                //是否是密码
                                obscureText: true,
                                //校验密码
                                validator: (value) {
                                  return value.length < 6 ? '密码长度不够 6 位' : null;
                                },
                                onSaved: (value) {
                                  password = value;
                                },
                              ),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      onPressed: _handleLogin,
                      child: Container(
                        height: 50.0,
                        width: ScreenUtil().getWidthPx(650),
                        child: Center(
                          child: Text(
                            "一键登录",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xffcb2b83),
                            ),
                          ),
                        ),
                      ),
                      color: Color.fromRGBO(0, 0, 0, 0.6),
                      elevation: 0.0,
                      focusElevation: 0.0,
                      highlightElevation: 0.0,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "我已阅读并同意《服务协议》及《隐私政策》",
                      style: TextStyle(color: Colors.white, fontSize: 13.0),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
