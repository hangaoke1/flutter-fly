import 'package:fluro/fluro.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_fly/provider/theme.dart';
import 'package:provider/provider.dart';
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
    setDesignWHD(750.0, 1336.0);
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = context.watch<ThemeProvider>();
  
    final app = MaterialApp(
      title: 'Fluro',
      builder: BotToastInit(),
      navigatorKey: Application.navigatorKey,
      navigatorObservers: [BotToastNavigatorObserver(), AppComponent.routeObserver],
      debugShowCheckedModeBanner: false,
      themeMode: theme.getThemeMode(),
      theme: theme.getTheme(),
      darkTheme:  theme.getTheme(isDarkMode: true),
      onGenerateRoute: Application.router.generator,
    );
    return app;
  }
}