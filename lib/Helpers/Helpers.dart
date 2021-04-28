import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Dio getDio() {
  Dio dio = new Dio();
  dio.options.followRedirects = false;
  dio.options.validateStatus = (status) {
    return status <= 500;
  };
  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers['Accept'] = 'application/json';
  dio.options.headers['Cache-Control'] = "No-Cache";
  dio.options.responseType = ResponseType.json;

  return dio;
}

TextStyle boldBlackStyle() {
  return TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
}

TextStyle boldBigFontStyle() {
  return TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25);
}
