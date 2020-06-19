import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fly/app.dart';

import 'package:flutter_fly/api/index.dart';
import 'package:flutter_fly/api/interceptor.dart';

import 'package:provider/provider.dart';
import 'package:flutter_fly/provider/user.dart';
import 'package:flutter_fly/provider/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  realRunApp();
}

void realRunApp() async {
  await SpUtil.getInstance();
  dio.interceptors.add(CustomInterceptors());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: AppComponent(),
    ),
  );
}
