import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wyy_flutter/core/utils/adapt.dart';
import 'package:wyy_flutter/core/utils/image_utils.dart';
import './login_controller.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({super.key});

  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    // 监听键盘显示状态
    WidgetsBinding.instance.addPostFrameCallback((_) {
      void keyboardListener() {
        final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
        controller.isKeyboardVisible.value = keyboardVisible;
      }

      // 首次检查
      keyboardListener();

      // 设置监听器
      WidgetsBinding.instance.addObserver(
        _KeyboardVisibilityObserver(() => keyboardListener()),
      );
    });

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFEDED), // #ff9a9e
              Color(0xFFFFFFFF),
            ],
            // 渐变到白色，白色大约在屏幕一半处开始
            stops: [0.0, 0.3], // 0% -> 35% -> 50%
          ),
        ),
        child: Stack(
          children: [
            _buildTopTitle(context), // 顶部标题栏 - 键盘显示时可见
            // 主内容
            SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(35.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, // 主轴居中
                          crossAxisAlignment: CrossAxisAlignment.center, // 侧轴居中
                          children: [
                            // Logo根据键盘状态有不同的位置
                            Obx(
                              () => AnimatedContainer(
                                duration: Duration(milliseconds: 250),
                                curve: Curves.easeOutCubic,
                                margin: EdgeInsets.only(
                                  top:
                                      controller.isKeyboardVisible.value ||
                                          controller.isShowCodeInput.value
                                      ? 0.h
                                      : 80.h,
                                ),
                                // 添加 transform 属性实现缩放效果
                                transform: Matrix4.identity()
                                  ..scale(
                                    controller.isShowCodeInput.value
                                        ? 0.4
                                        : 1.0, // 验证码输入时缩小到40%
                                    controller.isShowCodeInput.value
                                        ? 0.4
                                        : 1.0,
                                  ),
                                transformAlignment:
                                    Alignment.center, // 确保缩放中心点正确
                                child: _buildLogo(),
                              ),
                            ),
                            SizedBox(height: 200.h, width: double.infinity),
                            // _buildPhoneLogin(),
                            Obx(
                              () => controller.isShowCodeInput.value
                                  ? AnimatedSlide(
                                      offset: Offset(
                                        0,
                                        1 - controller.codeInputAnimation.value,
                                      ),
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeOutCubic,
                                      child: AnimatedOpacity(
                                        opacity:
                                            controller.codeInputAnimation.value,
                                        duration: Duration(milliseconds: 300),
                                        child: _buildCodeInput(),
                                      ),
                                    )
                                  : _buildPhoneLogin(),
                            ),
                          ],
                        ),
                      ),
                      _buildExperienceLocation(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      ImageUtils.getImagePath("erq"),
      height: 75.w,
      width: 75.w,
    );
  }

  // 立即体验定位
  Widget _buildExperienceLocation() {
    return Positioned(
      top: Adapt.topPadding() + 30,
      right: 0,
      child: GestureDetector(
        child: Text(
          "立即体验",
          style: TextStyle(fontSize: 12.sp, color: Color(0xFFbec2c5)),
        ),
      ),
    );
  }

  Widget _buildTopTitle(BuildContext context) {
    return Obx(
      () => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: AnimatedOpacity(
          opacity: controller.isKeyboardVisible.value ? 1.0 : 0.0,
          duration: Duration(milliseconds: 200),
          child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 8,
              bottom: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageUtils.getImagePath("erq"),
                  height: 24.w,
                  width: 24.w,
                ),
                SizedBox(width: 8.w),
                Text(
                  "网易云音乐",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF9A9E),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 渲染输入框（带点圆角，左侧是+86，右侧是输入手机号输入框（输入后带清空图标）
  /// 底部是验证码登录 按钮
  Widget _buildPhoneLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch, // 侧轴拉伸
      children: [
        GestureDetector(
          onTap: () {
            // 修复context引用，使用Get.context代替
            // 用来隐藏键盘，当用户点击超过这个范围以外就会移除焦点
            FocusScope.of(Get.context!).requestFocus(FocusNode());
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: Color(0xFFF1F4F5),
              borderRadius: BorderRadius.circular(12.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16.w),
                  ),
                  child: Text(
                    "+86",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xFF2A3248),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Container(width: 1, height: 15.h, color: Color(0xFFE4E7E9)),
                SizedBox(width: 12.w),
                Expanded(
                  child: TextField(
                    controller: controller.phoneController,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(fontSize: 16.sp),
                    decoration: InputDecoration(
                      hintText: "请输入手机号",
                      border: InputBorder.none,
                      isCollapsed: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                      suffixIcon: Obx(
                        () => controller.isPhoneEmpty.value
                            ? SizedBox.shrink()
                            : IconButton(
                                icon: Icon(Icons.clear, size: 18.w),
                                onPressed: () {
                                  controller.phoneController.clear();
                                },
                              ),
                      ),
                    ),
                    onChanged: (v) {
                      // TextEditingController的addListener会处理isPhoneEmpty的更新
                      controller.phoneController.text = v;
                      controller.phoneController.selection =
                          TextSelection.fromPosition(
                            TextPosition(offset: v.length),
                          );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 24.h),
        SizedBox(
          width: double.infinity,
          height: 40.h,
          child: Obx(() {
            // 使用新的shakeOffset实现平滑的晃动效果
            return Transform.translate(
              offset: Offset(controller.shakeOffset.value, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.w),
                  ),
                  backgroundColor: Color(0xFFFF3c39),
                  foregroundColor: Color(0xFFFF3c39),
                  shadowColor: Colors.transparent,
                  elevation: 0,
                ),
                onPressed: () {
                  controller.checkCodeLogin();
                },
                child: Text(
                  "验证码登录",
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 10.h),
        _buildPrivacyAgreement(),
      ],
    );
  }

  /// 渲染验证码输入
  Widget _buildCodeInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "已发送至${controller.phoneController.text}",
              style: TextStyle(fontSize: 12.sp, color: Color(0xFF747986)),
            ),
            GestureDetector(
              onTap: () {
                Get.snackbar("", "不提供这个功能！");
              },
              child: Text(
                "无法接收短信?",
                style: TextStyle(fontSize: 12.sp, color: Color(0xFF5975aa)),
              ),
            ),
          ],
        ),
        SizedBox(height: 30.h),
        GestureDetector(
          onTap: () {
            FocusScope.of(Get.context!).requestFocus(FocusNode());
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: Color(0xFFF1F4F5),
              borderRadius: BorderRadius.circular(12.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.codeController,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(fontSize: 16.sp),
                    decoration: InputDecoration(
                      hintText: "请输入验证码", // 提示文本
                      border: InputBorder.none, // 边框
                      isCollapsed: true, // 是否合并边框
                      contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                    ),
                    onChanged: (v) {
                      controller.codeController.text = v;
                      // 设置光标位置
                      controller.codeController.selection =
                          TextSelection.fromPosition(
                            TextPosition(offset: v.length),
                          );
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                Container(width: 1, height: 15.h, color: Color(0xFFE4E7E9)),
                SizedBox(width: 12.w),
                // 倒计时
                Obx(
                  () => Text(
                    controller.isShowCodeCountdown.value
                        ? "${controller.codeCountdown.value}s"
                        : "获取验证码",
                    style: TextStyle(fontSize: 16.sp, color: Color(0xFF5975aa)),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 30.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 圆的返回按钮图标
            GestureDetector(
              onTap: () {
                controller.isShowCodeInput.value = false;
              },
              child: CircleAvatar(
                backgroundColor: Color(0xFFF9F9F9),
                child: Icon(
                  Icons.arrow_back,
                  size: 18.w,
                  color: Color(0xFF757a8b),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // 隐私协议
  Widget _buildPrivacyAgreement() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 通过Transform.scale可以缩放Checkbox的显示大小
          Transform.scale(
            scale: 0.7, // 0.8倍缩放，调整为你想要的大小
            child: Obx(
              () => Checkbox(
                value: controller.isPrivacyAgreement.value,
                onChanged: (v) {
                  controller.isPrivacyAgreement.value = v ?? false;
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                splashRadius: double.infinity,
                activeColor: Color(0xFFbec2c5),
                side: BorderSide(color: Color(0xFFbec2c5), width: 1.w),
                materialTapTargetSize:
                    MaterialTapTargetSize.shrinkWrap, // 减小点击区域
                visualDensity: VisualDensity.compact, // 紧凑显示
              ),
            ),
          ),
          Text(
            "我已阅读并同意",
            style: TextStyle(fontSize: 12.sp, color: Color(0xFFbec2c5)),
          ),
          GestureDetector(
            onTap: () {
              // 跳转隐私协议
            },
            child: Text(
              "《隐私协议》、",
              style: TextStyle(color: Color(0xFF6384a6), fontSize: 12.sp),
            ),
          ),
          GestureDetector(
            onTap: () {
              // 跳转隐私协议
            },
            child: Text(
              "《隐私协议》、",
              style: TextStyle(color: Color(0xFF6384a6), fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }
}

// 键盘可见性监听器
class _KeyboardVisibilityObserver extends WidgetsBindingObserver {
  final Function callback;

  _KeyboardVisibilityObserver(this.callback);

  @override
  void didChangeMetrics() {
    callback();
    super.didChangeMetrics();
  }
}
