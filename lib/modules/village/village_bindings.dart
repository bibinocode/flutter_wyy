import 'package:get/get.dart';
import './village_controller.dart';

class VillageBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(VillageController());
    }
}