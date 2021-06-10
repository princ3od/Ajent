import 'package:ajent/app/data/models/Course.dart';
import 'package:ajent/app/data/services/course_service.dart';
import 'package:get/get.dart';

class MyCourseDetailController extends GetxController {
  Rx<Course> course;
  var isLoading = true.obs;
  @override
  onInit() async {
    super.onInit();
    course.value = await CourseService.instance.getCourse(course.value.id);
    await Future.delayed(Duration(milliseconds: 300));
    isLoading.value = false;
  }

  MyCourseDetailController(Course course) {
    this.course = course.obs;
  }
}
