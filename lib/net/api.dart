import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'interceptors/header_interceptor.dart';

/// 作者 mcy
/// 时间 2021/7/26 15:00
/// 请求
class HttpManager {
  static String URL = "";
  static String URL_IMAGE = "";

  Dio dio = new Dio();

  HttpManager() {
    dio.interceptors.add(new HeaderInterceptors());
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // 在发送请求之前做点什么
      debugPrint('---api-request--->url--> ${options.baseUrl}${options.path}' +
          ' queryParameters: ${options.data}');
      return handler.next(options); //continue
      // 如果你想完成请求并返回一些自定义数据，你可以resolve一个Response对象 `handler.resolve(response)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
      //
      // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象,如`handler.reject(error)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    }, onResponse: (response, handler) {
      //对响应数据进行处理
      return handler.next(response); // continue
      // 如果你想终止请求并触发一个错误,你可以 reject 一个`DioError`对象,如`handler.reject(error)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    }, onError: (DioError e, handler) {
      //做一些响应错误
      return handler.next(e); //continue
      // 如果你想完成请求并返回一些自定义数据，可以resolve 一个`Response`,如`handler.resolve(response)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
    }));
  }

  ///get请求
  Future get(String url, Map<String, dynamic> params) async {
    // params["ClientType"] = 3;
    var response = await dio.get(url, queryParameters: params);
    return response.data;
  }

  ///post请求
  Future post(String url, Map<String, dynamic> params) async {
    // params["ClientType"] = 3;
    var response = await dio.post(url, data: params);
    return response.data;
  }
}

final HttpManager httpManager = new HttpManager();
