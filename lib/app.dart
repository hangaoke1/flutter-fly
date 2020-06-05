import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pink[300],
      ),
      onGenerateRoute: Application.router.generator,
    );
    return app;
  }
}