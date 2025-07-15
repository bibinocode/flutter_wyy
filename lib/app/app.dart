import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:wyy_flutter/core/utils/storage_util.dart';


class Application {
  /// 主题 - 使用响应式变量 Td 组件库的主题
  /// @see https://tdesign.tencent.com/flutter/getting-started
  static final Rx<TDThemeData> themeData = TDThemeData.defaultData().obs;

  /// 页面初始化
  static Future<void> init() async {
    // 检查当前是否已初始化绑定，如果没有，则自动初始化。
    WidgetsFlutterBinding.ensureInitialized();

    // 系统UI样式配置
    setSystemUIOverlayStyle();
    // 初始化全局存储
    await StorageUtil.init();

    // 通知更新 返回一个已经完成的 Future
    return Future.value();
  }

  /// 设置系统 UI 样式
  static void setSystemUIOverlayStyle() {
    // 设置屏幕方向竖屏
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
    // 设置系统 UI显示模式 edgeToEdge: 显示状态栏（也就是内容会延生到状态栏，状态栏会覆盖在上面） immersiveSticky 不显示状态栏
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // Android平台特定的UI设置
    if(GetPlatform.isAndroid){
      const SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // 状态栏透明
        statusBarBrightness:Brightness.dark, // 状态栏文字颜色
        statusBarIconBrightness: Brightness.dark, // 状态栏图标颜色
        systemNavigationBarColor: Colors.transparent, // 导航栏透明 适配安卓小横条
         systemNavigationBarDividerColor: Colors.transparent, // 导航栏分割线透明
        systemNavigationBarIconBrightness: Brightness.dark, // 导航栏图标亮度
      );

      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    // IOS 平台特定的 UI 设置
    if (GetPlatform.isIOS) {
      const SystemUiOverlayStyle dark = SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFF000000), // 导航栏颜色
        systemNavigationBarIconBrightness: Brightness.light, // 导航栏图标亮度
        statusBarIconBrightness: Brightness.dark, // 状态栏图标亮度
        statusBarBrightness: Brightness.light, // 状态栏亮度
      );
      SystemChrome.setSystemUIOverlayStyle(dark);
    }
    // 设置导航栏颜色
  }


  /// TODO: 待实现 设置主题样式 
}