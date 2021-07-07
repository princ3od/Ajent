import 'dart:collection';

import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/services/course_service.dart';
import 'package:ajent/app/data/services/user_service.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:get/get.dart';

class MyTeachingDetailController extends GetxController {
  Rx<Course> course;

  var isLoading = true.obs;
  var isJoining = false.obs;
  var isSharing = false.obs;

  var joinable = false.obs;
  var editable = false.obs;
  AjentUser teacher;
  Map<String, AjentUser> learners = Map();
  @override
  onInit() async {
    super.onInit();
    course.value = await CourseService.instance.getCourse(course.value.id);
    if (course.value.teacher != null && course.value.teacher.isNotEmpty)
      teacher = await UserService.instance.getUser(course.value.teacher);
    else
      teacher = null;
    // if (course.value.learners != null)
    //   learners =
    //       await CourseService.instance.getLearners(course.value.learners);
    joinable.value = (course.value.status == CourseStatus.upcoming &&
        !course.value.learners.contains(HomeController.mainUser.uid) &&
        course.value.teacher != HomeController.mainUser.uid);
    editable.value = (HomeController.mainUser.uid == course.value.owner &&
        course.value.status == CourseStatus.upcoming);
    isLoading.value = false;
  }

  MyTeachingDetailController(Course course) {
    this.course = course.obs;
  }

  String getLearners() {
    String result = "";
    if (learners.length == 0) return "Not available".tr;
    for (var learner in learners.values) {
      result += learner.name + "; ";
    }
    return result;
  }
}
