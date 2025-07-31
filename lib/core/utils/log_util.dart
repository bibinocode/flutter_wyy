import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LogUtil {
  static final Logger _logger = Logger(
    level: kReleaseMode ? Level.off : Level.trace, // 生产环境关闭日志，开发环境开启日志
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true, // 确保启用颜色
      printEmojis: true,
    ),
  );

  /// debug 日志 打印出来是白色
  static void debug(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// error日志 打印出来是红色
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// info日志 打印出来是蓝色
  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// warning日志 打印出来是黄色
  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// verbose日志 打印出来是灰色
  static void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.v(message, error: error, stackTrace: stackTrace);
  }
}
