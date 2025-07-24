import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wyy_flutter/app/app_exception.dart';

/// 错误拦截器
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppException appException = AppException.create(err);
    debugPrint('ErrorInterceptor: ${appException.toString()}');
    // 复制一个错误对象
    DioException tmpErr = err.copyWith(error: appException);
    super.onError(tmpErr, handler);
  }
}
