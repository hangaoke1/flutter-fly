import 'package:flutter/material.dart';
import 'package:flutter_fly/app.dart';

import 'package:flutter_fly/api/index.dart';
import 'package:flutter_fly/api/interceptor.dart';
import 'package:flutter_fly/storage/index.dart';

import 'package:provider/provider.dart';
import 'package:flutter_fly/provider/user.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  realRunApp();
}

void realRunApp() async {
  bool success = await SpUtil.getInstance();
  print("init-" + success.toString());
  dio.interceptors.add(CustomInterceptors());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: AppComponent(),
    ),
  );
}
