import 'package:dio/dio.dart';

class DioHelpers {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true
      ),
    );
  }

  static Future<Response> getData(
      {required String url, required Map<String, dynamic> query}) {
    return dio
        .get(
      url,
      queryParameters: query,
    );
  }
}
