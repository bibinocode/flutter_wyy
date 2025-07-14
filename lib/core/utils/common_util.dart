import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wyy_flutter/config/themes/app_themes.dart';

///状态栏颜色设置，此方法抽出来了，全项目可以直接调用
getSystemUiOverlayStyle({bool isDark = true}) {
  SystemUiOverlayStyle value;
  if (Platform.isAndroid) {
    value = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,

      /// 安卓系统状态栏存在底色，所以需要加这个
      systemNavigationBarColor:
          isDark ? AppThemes.tabBgColor : AppThemes.darkTabBgColor,
      systemNavigationBarIconBrightness:
          isDark ? Brightness.dark : Brightness.light,
      statusBarIconBrightness: isDark ? Brightness.dark : Brightness.light,

      /// 状态栏字体颜色
      statusBarBrightness: isDark ? Brightness.light : Brightness.dark,
    );
  } else {
    value = isDark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light;
  }
  return value;
}

class CommonUtil {}