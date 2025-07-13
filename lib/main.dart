import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'application.dart';


/// 应用入口
void main() => Application.init().then((value) => runApp(const MainApp()));


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context){
    /// 屏幕适配
    return ScreenUtilInit(
      splitScreenMode: true, // 是否支持分屏
      minTextAdapt: true, // 是否根据最小宽度适配文字
      designSize: const Size(375, 812), // 设计稿尺寸
      builder: (context,child){
        return Obx((){
          // 响应式获取
          return GetMaterialApp(
            debugShowCheckedModeBanner: false, // 隐藏调试模式
            defaultTransition: Transition.rightToLeft,  // 页面切换动画
            title: "App 应用标题",
            color: Colors.transparent, // 设置应用主题颜色
          );
        });
      },
    );
  }
}