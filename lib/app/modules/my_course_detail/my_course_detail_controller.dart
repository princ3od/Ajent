import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/services/course_service.dart';
import 'package:ajent/app/data/services/user_service.dart';
import 'package:get/get.dart';

class MyCourseDetailController extends GetxController {
  Rx<Course> course;
  var isLoading = true.obs;
  AjentUser teacher;
  @override
  onInit() async {
    super.onInit();
    course.value = await CourseService.instance.getCourse(course.value.id);
    if (course.value.teacher != null && course.value.teacher.isNotEmpty)
      teacher = await UserService.instance.getUser(course.value.teacher);
    else
      teacher = null;
    await Future.delayed(Duration(milliseconds: 100));
    isLoading.value = false;
  }

  MyCourseDetailController(Course course) {
    this.course = course.obs;
  }
}
