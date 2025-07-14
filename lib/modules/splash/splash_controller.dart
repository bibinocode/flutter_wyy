import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wyy_flutter/core/utils/storage_util.dart';

class SplashController extends GetxController with GetSingleTickerProviderStateMixin {

 final bool isFirst = StorageUtil.getBool('isFirst', defaultValue: true);

  @override
  void onInit() {
    super.onInit();
    // 需要展示状态栏 TOP
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: [SystemUiOverlay.top]);
  }

   @override
  Future<void> onReady() async {
    super.onReady();
    // 延迟 6s 或者 2s 跳转
    await Future.delayed(Duration(milliseconds: isFirst ? 6000 : 2000));
    toHome();
  }

  @override
  void onClose() {
    super.onClose();
    //需要展示状态栏Top ,Bottom
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  }

  void toHome() {
    StorageUtil.setBool('isFirst', false);
    Get.offAllNamed('/home');
  }
}