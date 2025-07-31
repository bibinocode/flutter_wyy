import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wyy_flutter/core/utils/log_util.dart';
import 'package:wyy_flutter/shared/api/login_service.dart';

// 登录类型枚举
enum LoginType {
  phone, // 手机号登录
  email, // 邮箱登录
  qrCode, // 二维码登录
  guest, // 游客登录
}

class LoginController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // 登录方式
  final loginType = LoginType.phone.obs;

  // 手机号输入完成，点击验证码登录 然后开始显示验证码输入框
  final isShowCodeInput = false.obs;

  // 控制验证码输入框的动画
  final codeInputAnimation = Rx<double>(0.0);

  // 手机号文本输入框控制器
  final phoneController = TextEditingController();

  // 手机号是否为空
  final isPhoneEmpty = true.obs;

  // 验证码文本输入框控制器
  final codeController = TextEditingController();

  // 验证码倒计时
  final codeCountdown = 60.obs;

  // 是否显示验证码倒计时
  final isShowCodeCountdown = false.obs;

  // 键盘是否显示
  final isKeyboardVisible = false.obs;

  // 验证码按钮抖动
  final codeButtonShake = false.obs;

  // 抖动动画控制器
  late AnimationController shakeController;
  late Animation<double> shakeAnimation;
  final shakeOffset = 0.0.obs;

  // 隐私些是否同意
  final isPrivacyAgreement = false.obs;

  // 检测验证码登录逻辑
  void checkCodeLogin() async {
    // 为输入手机号，按钮进行抖动动画
    if (isPhoneEmpty.value) {
      Get.snackbar("提示", "请输入手机号");
      startShakeAnimation();
      return;
    }

    // 验证是否同意隐私协议
    if (!isPrivacyAgreement.value) {
      Get.snackbar("提示", "请先同意隐私协议");
      return;
    }

    // 发送验证码
    final response = await LoginService.instance.sendVerificationCode(
      phoneController.text,
    );

    LogUtil.i(response);

    // 进入验证码输入显示
    if (response.code == 200 && response.data == true) {
      // 先设置状态，然后开始动画
      isShowCodeInput.value = true;
      // 触发验证码输入框的动画
      _startCodeInputAnimation();
      Get.snackbar("", "验证码已发送");
      startCountdown();
    }
  }

  // 开始验证码输入框动画
  void _startCodeInputAnimation() {
    // 从0到1的动画过渡
    Timer(Duration(milliseconds: 50), () {
      codeInputAnimation.value = 1.0;
    });
  }

  /// 重新获取验证码
  void resetCode() async {
    codeController.clear();
    isShowCodeCountdown.value = false;
    // 发送验证码
    final response = await LoginService.instance.sendVerificationCode(
      phoneController.text,
    );

    LogUtil.i(response);

    if (response.code == 200 && response.data == true) {
      Get.snackbar("", "验证码已发送");
      startCountdown();
    }
  }

  // 开始倒计时
  void startCountdown() {
    codeCountdown.value = 60;
    isShowCodeCountdown.value = true;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (codeCountdown.value <= 0) {
        timer.cancel();
        isShowCodeCountdown.value = false;
      } else {
        codeCountdown.value--;
      }
    });
  }

  // 开始晃动动画
  void startShakeAnimation() {
    shakeController.reset();
    shakeController.forward();
  }

  @override
  void onInit() {
    super.onInit();

    // 监听手机号输入变化
    phoneController.addListener(() {
      isPhoneEmpty.value = phoneController.text.isEmpty;
    });

    // 初始化抖动动画控制器
    shakeController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    // 创建左右摇晃的动画效果
    shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 8.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: -6.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -6.0, end: 4.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 4.0, end: -2.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -2.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: shakeController, curve: Curves.easeOut));

    // 添加动画监听器来更新shakeOffset值
    shakeAnimation.addListener(() {
      shakeOffset.value = shakeAnimation.value;
    });
  }

  @override
  void onClose() {
    phoneController.dispose();
    codeController.dispose();
    shakeController.dispose();
    super.onClose();
  }
}
