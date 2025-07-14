import 'package:get/get.dart';
import 'splash_controller.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    // 懒加载 Controller
    Get.lazyPut<SplashController>(() => SplashController());
  }
}
