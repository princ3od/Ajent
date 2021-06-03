import 'package:ajent/app/modules/add_course/add_course_controller.dart';
import 'package:get/get.dart';

class AddCourseBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AddCourseController());
  }
}