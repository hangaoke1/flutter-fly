import 'package:dio/dio.dart';

BaseOptions options = BaseOptions(
  baseUrl: "http://110.80.137.93:3000/mock/200",
  connectTimeout: 5000,
  receiveTimeout: 3000,
);

Dio dio = Dio(options);
