import 'package:fluro/fluro.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fly/provider/theme.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:provider/provider.dart';
import './router/application.dart';
import './router/routes.dart';

class AppComponent extends StatefulWidget {
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();
  @override
  State createState() {
    return AppComponentState();
  }
}

class AppComponentState extends State<AppComponent> {
  AppComponentState() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
    setDesignWHD(750.0, 1336.0);
    // 极光推送
    JPush jpush = new JPush();
    jpush.addEventHandler(
      // 接收通知回调方法。
      onReceiveNotification: (Map<String, dynamic> message) async {
        print("极光推送 onReceiveNotification: $message");
        HapticFeedback.mediumImpact();
      },
      // 点击通知回调方法。
      onOpenNotification: (Map<String, dynamic> message) async {
        print("极光推送 onOpenNotification: $message");
      },
      // 接收自定义消息回调方法。
      onReceiveMessage: (Map<String, dynamic> message) async {
        print("极光推送 onReceiveMessage: $message");
      },
    );
    jpush.setup(
      appKey: "08feb47d5c66f68edf44492f", //你自己应用的 AppKey
      channel: "theChannel",
      production: false,
      debug: true,
    );
    jpush.getRegistrationID().then((rid) {
      print('---->rid:$rid');
    });
    jpush.applyPushAuthority(
      new NotificationSettingsIOS(sound: true, alert: true, badge: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = context.watch<ThemeProvider>();

    final app = MaterialApp(
      title: 'Fluro',
      builder: BotToastInit(),
      navigatorKey: Application.navigatorKey,
      navigatorObservers: [
        BotToastNavigatorObserver(),
        AppComponent.routeObserver
      ],
      debugShowCheckedModeBanner: false,
      themeMode: theme.getThemeMode(),
      theme: theme.getTheme(),
      darkTheme: theme.getTheme(isDarkMode: true),
      onGenerateRoute: Application.router.generator,
    );
    return app;
  }
}
