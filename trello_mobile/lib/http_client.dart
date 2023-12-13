import 'dart:developer';

import 'package:dio/dio.dart';

class HttpClient {
  Dio getDio() {
    Dio dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 5), receiveTimeout: const Duration(seconds: 10)));
    dio.options.headers['content-Type'] = "application/json";
    // mettre ici un token :
    // dio.options.headers['authorization'] = "Bearer ${Storage().accessToken}";
    return dio;
  }

  Future<Response> post(String route, dynamic data, String contentType) {
    return getDio().post(route, data: data).catchError((e) async {
      if (e.response != null) {
        log('Dio error!');
        log('STATUS: ${e.response?.statusCode}');
        log('DATA: ${e.response?.data}');
        log('HEADERS: ${e.response?.headers}');
        throw e.message;
      } else {
        log('Error sending request!');
        log(e.message);
        throw e.message;
      }
    });
  }

  Future<Response> patch(String route, dynamic data, String contentType) {
    return getDio().patch(route, data: data).catchError((e) async {
      if (e.response != null) {
        log('Dio error!');
        log('STATUS: ${e.response?.statusCode}');
        log('DATA: ${e.response?.data}');
        log('HEADERS: ${e.response?.headers}');
        throw e.message;
      } else {
        log('Error sending request!');
        log(e.message);
        throw e.message;
      }
    });
  }

  Future<Response> get(String route) {
    return getDio().get(route).catchError((e) async {
      if (e.response != null) {
        log('Dio error!');
        log('STATUS: ${e.response?.statusCode}');
        log('DATA: ${e.response?.data}');
        log('HEADERS: ${e.response?.headers}');
        throw e.message;
      } else {
        log('Error sending request!');
        log(e.message);
        throw e.message;
      }
    });
  }
}
