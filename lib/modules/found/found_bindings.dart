import 'package:get/get.dart';
import './found_controller.dart';

class FoundBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(FoundController());
    }
}