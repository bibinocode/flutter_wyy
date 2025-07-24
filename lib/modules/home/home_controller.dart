import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  final currentIndex = 0.obs;

  final pageController = PageController();

  /// 广播流
  final StreamController<bool> homeMenuStream =
      StreamController<bool>.broadcast();

  /// 监听页面关闭事件
  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void changePage(int index) {
    currentIndex.value = index;
    // 跳转页面
    pageController.jumpToPage(index);

    if (index == 4) {
      homeMenuStream.add(true);
    } else {
      homeMenuStream.add(false);
    }
  }
}
