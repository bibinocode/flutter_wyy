import 'package:get/get.dart';
import './dynamic_controller.dart';

class DynamicBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(DynamicController());
    }
}