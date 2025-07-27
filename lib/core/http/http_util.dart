import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wyy_flutter/core/http/http.dart';

class HttpUtil {
  static late Http _http;

  static Future<void> init({
    String baseUrl = 'http://localhost:3000/api/',
    int? connectTimeout,
    int? receiveTimeout,
    List<Interceptor>? interceptors,
  }) async {
    await Http.init(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      interceptors: interceptors,
    );
    _http = Http();
  }

  /// 单例模式
  static HttpUtil? _instance;
  static HttpUtil get instance => _instance ??= HttpUtil._();
  HttpUtil._();

  static void setHeaders(Map<String, dynamic> map) {
    _http.setHeaders(map);
  }

  static Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool refresh = false,
  }) async {
    // 确保所有请求都带上withCredentials
    options ??= Options();
    options.extra ??= {};
    options.extra!['withCredentials'] = true;

    return await _http.get(
      path,
      params: queryParameters,
      options: options,
      refresh: refresh,
    );
  }

  static Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    // 确保所有请求都带上withCredentials
    options ??= Options();
    options.extra ??= {};
    options.extra!['withCredentials'] = true;

    return await _http.post(
      path,
      data: data,
      params: queryParameters,
      options: options,
    );
  }

  static Future put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    // 确保所有请求都带上withCredentials
    options ??= Options();
    options.extra ??= {};
    options.extra!['withCredentials'] = true;

    return await _http.put(
      path,
      data: data,
      params: queryParameters,
      options: options,
    );
  }

  static Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    // 确保所有请求都带上withCredentials
    options ??= Options();
    options.extra ??= {};
    options.extra!['withCredentials'] = true;

    return await _http.delete(
      path,
      data: data,
      params: queryParameters,
      options: options,
    );
  }

  static Future<bool> checkCookie() async {
    return await Http.checkCookie();
  }

  static Future<void> clearCookie() async {
    await Http.clearCookie();
  }

  static Future<List<Cookie>> loadCookies({Uri? host}) async {
    host ??= Uri.parse(Http.baseUrl);
    return await Http.loadCookies(host: host);
  }
}
