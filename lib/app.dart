import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import './router/application.dart';
import './router/routes.dart';

class AppComponent extends StatefulWidget {
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
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pink[300],
      ),
      onGenerateRoute: Application.router.generator,
    );
    return app;
  }
}