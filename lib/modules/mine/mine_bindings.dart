import 'package:get/get.dart';
import './mine_controller.dart';

class MineBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(MineController());
    }
}