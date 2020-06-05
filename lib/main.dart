import 'package:flutter/material.dart';
import 'package:hello_world/app.dart';

import 'package:hello_world/api/index.dart';
import 'package:hello_world/api/interceptor.dart';
import 'package:hello_world/storage/index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  realRunApp();
}

void realRunApp() async {
  bool success = await SpUtil.getInstance();
  print("init-"+success.toString());
  dio.interceptors
      .add(CustomInterceptors());
  runApp(AppComponent());
}
