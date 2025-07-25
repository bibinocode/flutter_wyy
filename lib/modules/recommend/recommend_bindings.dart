import 'package:get/get.dart';
import './recommend_controller.dart';

class RecommendBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(RecommendController());
    }
}