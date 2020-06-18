import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import './router/application.dart';
import './router/routes.dart';

class AppComponent extends StatefulWidget {
  static final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
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
  }

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: 'Fluro',
      builder: BotToastInit(),
      navigatorKey: Application.navigatorKey,
      navigatorObservers: [BotToastNavigatorObserver(), AppComponent.routeObserver],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primaryColor: Colors.pink[300],
        // primarySwatch: Colors.pink
        primaryColor: Colors.red,
        primarySwatch: Colors.red
      ),
      onGenerateRoute: Application.router.generator,
    );
    return app;
  }
}