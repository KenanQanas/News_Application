import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news/cache/cache_helper.dart';
import 'package:news/dio_helpers/dio_helpers.dart';

import 'my_app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  await CacheHelper.init();
  DioHelpers.init();

  runApp(
    MyApp(CacheHelper.getData(key: 'isDark')),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
