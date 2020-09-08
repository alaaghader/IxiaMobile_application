import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common.dart';

SharedPreferences _sp;
final _spFuture = SharedPreferences.getInstance().then((sp) => _sp = sp);

Future<String> getToken() async {
  if (_sp == null) {
    await _spFuture;
  }
  return _sp.getString('accessToken');
}

Dio _createHttpClient() {
  var dio = Dio(BaseOptions(connectTimeout: 250000));
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options) async {
        options.headers.addAll({
          HttpHeaders.authorizationHeader: 'Bearer ${await getToken()}',
        });

        options.path = url(options.path);

        if (!kReleaseMode) {
          print('[${options.method}] ${options.path}'
              ' ${jsonEncode(options.queryParameters)}');
          // simulate network delay for debugging purposes
          await Future.delayed(Duration(seconds: 1));
        }
        return options;
      },
      onError: (error) {
        print(error);
        return error.response;
      },
    ),
  );
  return dio;
}

Dio _dio = _createHttpClient();

Dio get dio => _dio;
