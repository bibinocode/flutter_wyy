import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

/// 一些适配工具类，防止 插件 API 变化，后续版本可能需要修改
class Adapt {
  Adapt._(); // 私有构造函数

  static double _width = 0; // 屏幕宽度
  static double _height = 0; // 屏幕高度
  static double _topPadding = 0; // 顶部安全距离
  static double _bottomPadding = 0; // 底部安全距离

  static double? _ratio; // 屏幕宽高比

  static double _devicePixelRatio = 0; // 设备像素比

  static bool padding_b_h = false; // 是否需要底部安全距离

 
  static initContext(BuildContext context){
    context.isDarkMode;
    /// 类似于 MediaQuery.of(context).size。
    final size = MediaQuery.sizeOf(context);
    // 屏幕宽度
    if (_width == 0 || _height == 0) {
      _width = size.width;
      _height = size.height;
    }
    /// 底部安全距离
    if (_bottomPadding == 0) {
      _bottomPadding = MediaQuery.paddingOf(context).bottom;
      padding_b_h = true;
    }
    /// 顶部安全距离
    if (_topPadding == 0) {
      _topPadding = MediaQuery.paddingOf(context).top;
    }
    /// 设备像素比
    if (_devicePixelRatio == 0) {
      _devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    }
    
  }

  /// 初始化屏幕宽高比
  static void _init(int number) {
    _ratio = _width / number;
  }

  static double px(double number) {
    if (_ratio == null || (_ratio ?? 0) <= 0) {
      Adapt._init(375);
    }
    if (!(_ratio is double || _ratio is int)) {
      Adapt._init(375);
    }
    return number * _ratio!;
  }

  static double screenW() {
    return _width;
  }

  static double screenH() {
    return _height;
  }

  static double bottomPadding() {
    return _bottomPadding;
  }

  static double topPadding() {
    return _topPadding;
  }

  
  static double contentHeight() {
    return screenH() - topPadding() - bottomPadding();
  }

  static double devicePixelRatio() {
    return _devicePixelRatio;
  }
  
  
}