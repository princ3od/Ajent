import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/app/modules/learning/learning_controlller.dart';
import 'package:ajent/app/modules/teaching/teaching_controller.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LearningController());
    Get.lazyPut(() => TeachingController());
    Get.lazyPut(() => HomeController());
  }
}
