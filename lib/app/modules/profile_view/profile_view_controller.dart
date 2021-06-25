import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/services/user_service.dart';
import 'package:get/get.dart';

import '../../data/models/ajent_user.dart';
import '../../data/models/course.dart';
import '../../data/models/evaluation.dart';
import '../../data/services/course_service.dart';
import '../../data/services/course_service.dart';

class ProfileViewController extends GetxController {
  var averageStar = (-2.0).obs;
  var reviewNum = (-1).obs;
  double totalStar = 0;
  List<Course> teachingCourses = [];
  Map<String, Evaluation> evaluations = Map();
  AjentUser user;
  @override
  void onInit() async {
    super.onInit();
    user = Get.arguments;
    getEvaluations();
  }

  getEvaluations() async {
    teachingCourses =
        await CourseService.instance.getUserTeachingCourse(user.uid);
    for (var course in teachingCourses) {
      evaluations
          .addAll(await CourseService.instance.getEvaluations(course.id));
    }
    for (var evaluation in evaluations.values) {
      totalStar += evaluation.star;
    }
    reviewNum.value = evaluations.length;
    averageStar.value =
        (evaluations.length > 0) ? (totalStar / evaluations.length) : -1.0;
  }
}
