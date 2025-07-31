import 'dart:convert';

import 'package:get/get.dart';
import 'package:wyy_flutter/core/http/http_util.dart';
import 'package:wyy_flutter/core/utils/log_util.dart';
import '../models/login_models.dart';

class LoginService {
  static LoginService? _instance;
  static LoginService get instance => _instance ??= LoginService._();
  LoginService._();

  // HttpUtil 实例不再需要，直接使用类名调用静态方法

  /// 发送验证码
  Future<SendVerificationCodeResponse> sendVerificationCode(
    String phone,
  ) async {
    try {
      final response = await HttpUtil.get(
        "/captcha/sent",
        queryParameters: {"phone": phone},
      );

      // HttpUtil.get() 已经返回解析好的 JSON 对象，不需要再用 jsonDecode
      return SendVerificationCodeResponse.fromJson(response);
    } catch (e) {
      LogUtil.e(e);
      _handleError();
      // 返回一个错误响应，而不是返回null
      return SendVerificationCodeResponse(code: 500, data: false);
    }
  }

  /// 统一错误处理
  SnackbarController _handleError() {
    return Get.snackbar("错误提示", "网络请求错误");
  }
}
