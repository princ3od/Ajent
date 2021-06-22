import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/services/course_service.dart';
import 'package:ajent/app/data/services/user_service.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:get/get.dart';

class MyCourseDetailController extends GetxController {
  Rx<Course> course;

  var isLoading = true.obs;
  var isJoining = false.obs;
  var isSharing = false.obs;
  var isRequesting = false.obs;

  var joinable = false.obs;
  var requestable = false.obs;
  AjentUser teacher;
  @override
  onInit() async {
    super.onInit();
    course.value = await CourseService.instance.getCourse(course.value.id);
    if (course.value.teacher != null && course.value.teacher.isNotEmpty)
      teacher = await UserService.instance.getUser(course.value.teacher);
    else
      teacher = null;
    course.value.evaluations =
        await CourseService.instance.getEvaluations(course.value.id);
    joinable.value = (course.value.status == CourseStatus.upcoming &&
        !course.value.learners.contains(HomeController.mainUser.uid));
    requestable.value = (joinable.value &&
        course.value.owner != HomeController.mainUser.uid &&
        (course.value.teacher == null || course.value.teacher.isEmpty));
    isLoading.value = false;
  }

  MyCourseDetailController(Course course) {
    this.course = course.obs;
  }

  joinCourse() async {
    isJoining.value = true;
    course.value.learners.add(HomeController.mainUser.uid);
    await CourseService.instance.updateLearnners(course.value);
    isJoining.value = false;
    joinable.value = false;
  }
}
