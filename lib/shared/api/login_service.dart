import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:wyy_flutter/core/http/http_util.dart';
import '../../core/http/http.dart';
import '../../core/utils/storage_util.dart';
import '../models/login_models.dart';

class LoginService {
  static LoginService? _instance;
  static LoginService get instance => _instance ??= LoginService._();
  LoginService._();

  // HttpUtil 实例不再需要，直接使用类名调用静态方法

  // Cookie存储key
  static const String _cookieKey = 'music_cookie';
  static const String _userInfoKey = 'user_info';

  /// 当前用户信息
  UserInfo? _currentUser;
  UserInfo? get currentUser => _currentUser;

  /// 当前登录状态
  bool get isLoggedIn => _currentUser != null && _getCachedCookie().isNotEmpty;

  /// 获取缓存的Cookie
  String _getCachedCookie() {
    return StorageUtil.getString(_cookieKey) ?? '';
  }

  /// 保存Cookie
  Future<void> _saveCookie(String cookie) async {
    await StorageUtil.setString(_cookieKey, cookie);
  }

  /// 保存用户信息
  Future<void> _saveUserInfo(UserInfo userInfo) async {
    _currentUser = userInfo;
    await StorageUtil.setString(_userInfoKey, userInfo.toJson().toString());
  }

  /// 加载用户信息
  Future<void> loadUserInfo() async {
    final userInfoStr = StorageUtil.getString(_userInfoKey);
    if (userInfoStr != null && userInfoStr.isNotEmpty) {
      try {
        // 这里需要正确解析JSON字符串
        final userInfo = UserInfo.fromJson(jsonDecode(userInfoStr));
        _currentUser = userInfo;
      } catch (e) {
        print('加载用户信息失败: $e');
      }
    }
  }

  /// 清除登录状态
  Future<void> clearLoginState() async {
    _currentUser = null;
    await StorageUtil.delete(_cookieKey);
    await StorageUtil.delete(_userInfoKey);
  }

  /// 检查登录状态，防止重复登录
  Future<bool> checkLoginStatus() async {
    if (!isLoggedIn) return false;

    try {
      final response = await getLoginStatus();
      if (response.isLoggedIn) {
        // 更新用户信息
        if (response.profile != null) {
          await _saveUserInfo(response.profile!);
        }
        return true;
      } else {
        // 登录状态失效，清除本地缓存
        await clearLoginState();
        return false;
      }
    } catch (e) {
      print('检查登录状态失败: $e');
      return false;
    }
  }

  /// 发送手机验证码
  /// [phone] 手机号码
  /// [ctcode] 国家区号，默认86（中国）
  Future<CaptchaSendResponse> sendSmsCode(
    String phone, {
    String ctcode = '86',
  }) async {
    try {
      final response = await HttpUtil.get(
        '/captcha/sent',
        queryParameters: {
          'phone': phone,
          'ctcode': ctcode,
          // 添加时间戳防止缓存
          '_t': DateTime.now().millisecondsSinceEpoch,
        },
        options: Options(extra: {'withCredentials': true}),
      );

      return CaptchaSendResponse.fromJson(response.data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// 验证验证码
  /// [phone] 手机号码
  /// [captcha] 验证码
  /// [ctcode] 国家区号，默认86（中国）
  Future<CaptchaVerifyResponse> verifySmsCode(
    String phone,
    String captcha, {
    String ctcode = '86',
  }) async {
    try {
      final response = await HttpUtil.get(
        '/captcha/verify',
        queryParameters: {
          'phone': phone,
          'captcha': captcha,
          'ctcode': ctcode,
          '_t': DateTime.now().millisecondsSinceEpoch,
        },
        options: Options(extra: {'withCredentials': true}),
      );

      return CaptchaVerifyResponse.fromJson(response.data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// 手机号登录
  /// [phone] 手机号码
  /// [password] 密码（可选）
  /// [captcha] 验证码（可选，传入后password失效）
  /// [countrycode] 国家码，默认86（中国）
  Future<PhoneLoginResponse> phoneLogin({
    required String phone,
    String? password,
    String? captcha,
    String countrycode = '86',
  }) async {
    // 防止重复登录
    if (isLoggedIn) {
      final isValid = await checkLoginStatus();
      if (isValid) {
        throw Exception('已登录，请勿重复登录');
      }
    }

    try {
      final params = <String, dynamic>{
        'phone': phone,
        'countrycode': countrycode,
        '_t': DateTime.now().millisecondsSinceEpoch,
      };

      // 优先使用验证码登录
      if (captcha != null && captcha.isNotEmpty) {
        params['captcha'] = captcha;
      } else if (password != null && password.isNotEmpty) {
        // 建议对密码进行编码
        params['password'] = Uri.encodeComponent(password);
      } else {
        throw Exception('请提供密码或验证码');
      }

      final response = await HttpUtil.get(
        '/login/cellphone',
        queryParameters: params,
        options: Options(extra: {'withCredentials': true}),
      );

      final loginResponse = PhoneLoginResponse.fromJson(response.data);

      // 登录成功，保存Cookie和用户信息
      if (loginResponse.isSuccess) {
        if (loginResponse.cookie != null) {
          await _saveCookie(loginResponse.cookie!);
        }
        if (loginResponse.profile != null) {
          await _saveUserInfo(loginResponse.profile!);
        }
      }

      return loginResponse;
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// 邮箱登录
  /// [email] 邮箱地址
  /// [password] 密码
  Future<EmailLoginResponse> emailLogin({
    required String email,
    required String password,
  }) async {
    // 防止重复登录
    if (isLoggedIn) {
      final isValid = await checkLoginStatus();
      if (isValid) {
        throw Exception('已登录，请勿重复登录');
      }
    }

    try {
      final response = await HttpUtil.get(
        '/login',
        queryParameters: {
          'email': email,
          'password': Uri.encodeComponent(password),
          '_t': DateTime.now().millisecondsSinceEpoch,
        },
        options: Options(extra: {'withCredentials': true}),
      );

      final loginResponse = EmailLoginResponse.fromJson(response.data);

      // 登录成功，保存Cookie和用户信息
      if (loginResponse.isSuccess) {
        if (loginResponse.cookie != null) {
          await _saveCookie(loginResponse.cookie!);
        }
        if (loginResponse.profile != null) {
          await _saveUserInfo(loginResponse.profile!);
        }
      }

      return loginResponse;
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// 生成二维码Key
  Future<QRKeyResponse> generateQRKey() async {
    try {
      final response = await HttpUtil.get(
        '/login/qr/key',
        queryParameters: {'_t': DateTime.now().millisecondsSinceEpoch},
        options: Options(extra: {'withCredentials': true}),
      );

      return QRKeyResponse.fromJson(response.data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// 生成二维码
  /// [key] 二维码Key
  /// [qrimg] 是否返回二维码图片base64
  Future<QRCreateResponse> createQRCode(String key, {bool qrimg = true}) async {
    try {
      final params = <String, dynamic>{
        'key': key,
        '_t': DateTime.now().millisecondsSinceEpoch,
      };

      if (qrimg) {
        params['qrimg'] = 'true';
      }

      final response = await HttpUtil.get(
        '/login/qr/create',
        queryParameters: params,
        options: Options(extra: {'withCredentials': true}),
      );

      return QRCreateResponse.fromJson(response.data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// 检查二维码状态
  /// [key] 二维码Key
  Future<QRCheckResponse> checkQRStatus(String key) async {
    try {
      final response = await HttpUtil.get(
        '/login/qr/check',
        queryParameters: {
          'key': key,
          '_t': DateTime.now().millisecondsSinceEpoch,
        },
        options: Options(extra: {'withCredentials': true}),
      );

      final checkResponse = QRCheckResponse.fromJson(response.data);

      // 登录成功，保存Cookie和用户信息
      if (checkResponse.status == QRStatus.confirmed &&
          checkResponse.isSuccess) {
        if (checkResponse.cookie != null) {
          await _saveCookie(checkResponse.cookie!);
        }
        if (checkResponse.profile != null) {
          await _saveUserInfo(checkResponse.profile!);
        }
      }

      return checkResponse;
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// 游客登录
  Future<AnonymousLoginResponse> anonymousLogin() async {
    try {
      final response = await HttpUtil.get(
        '/register/anonimous',
        queryParameters: {'_t': DateTime.now().millisecondsSinceEpoch},
        options: Options(extra: {'withCredentials': true}),
      );

      final loginResponse = AnonymousLoginResponse.fromJson(response.data);

      // 游客登录成功，保存Cookie
      if (loginResponse.isSuccess && loginResponse.cookie != null) {
        await _saveCookie(loginResponse.cookie!);
      }

      return loginResponse;
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// 获取登录状态
  Future<LoginStatusResponse> getLoginStatus() async {
    try {
      final response = await HttpUtil.get(
        '/login/status',
        queryParameters: {'_t': DateTime.now().millisecondsSinceEpoch},
        options: Options(extra: {'withCredentials': true}),
      );

      return LoginStatusResponse.fromJson(response.data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// 刷新登录状态
  Future<BaseLoginResponse> refreshLogin() async {
    try {
      final response = await HttpUtil.get(
        '/login/refresh',
        queryParameters: {'_t': DateTime.now().millisecondsSinceEpoch},
        options: Options(extra: {'withCredentials': true}),
      );

      final refreshResponse = BaseLoginResponse.fromJson(response.data);

      // 刷新成功，更新Cookie
      if (refreshResponse.isSuccess && refreshResponse.cookie != null) {
        await _saveCookie(refreshResponse.cookie!);
      }

      return refreshResponse;
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// 退出登录
  Future<void> logout() async {
    try {
      await HttpUtil.get(
        '/logout',
        queryParameters: {'_t': DateTime.now().millisecondsSinceEpoch},
        options: Options(extra: {'withCredentials': true}),
      );
    } catch (e) {
      print('退出登录失败: $e');
    } finally {
      // 无论是否成功，都清除本地状态
      await clearLoginState();
    }
  }

  /// 获取用户详情
  /// [uid] 用户ID
  Future<UserDetailResponse> getUserDetail(int uid) async {
    try {
      final response = await HttpUtil.get(
        '/user/detail',
        queryParameters: {
          'uid': uid,
          '_t': DateTime.now().millisecondsSinceEpoch,
        },
        options: Options(extra: {'withCredentials': true}),
      );

      return UserDetailResponse.fromJson(response.data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// 获取账号信息
  Future<UserAccountResponse> getUserAccount() async {
    try {
      final response = await HttpUtil.get(
        '/user/account',
        queryParameters: {'_t': DateTime.now().millisecondsSinceEpoch},
        options: Options(extra: {'withCredentials': true}),
      );

      return UserAccountResponse.fromJson(response.data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// 统一错误处理
  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.response?.statusCode) {
        case 301:
          return Exception('未登录或登录状态已过期');
        case 503:
          return Exception('请求过于频繁，请稍后再试');
        case 460:
          return Exception('网络异常，请检查网络连接');
        default:
          final message =
              error.response?.data?['message'] ??
              error.response?.data?['msg'] ??
              error.message ??
              '网络请求失败';
          return Exception(message);
      }
    }
    return Exception(error.toString());
  }
}
