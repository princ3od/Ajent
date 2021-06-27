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
  var editable = false.obs;

  var scrollOffset = (0.0).obs;
  var showMore = false.obs;
  AjentUser teacher;
  var learners = <AjentUser>[].obs;

  String timeOverall = '';
  @override
  onInit() async {
    super.onInit();
    course.value = await CourseService.instance.getCourse(course.value.id);
    if (course.value.teacher != null && course.value.teacher.isNotEmpty)
      teacher = await UserService.instance.getUser(course.value.teacher);
    else
      teacher = null;
    if (course.value.learners != null) {
      learners.value =
          await CourseService.instance.getLearners(course.value.learners);
    }
    course.value.evaluations =
        await CourseService.instance.getEvaluations(course.value.id);
    joinable.value = (course.value.status == CourseStatus.upcoming &&
        !course.value.learners.contains(HomeController.mainUser.uid));
    requestable.value = (joinable.value &&
        course.value.owner != HomeController.mainUser.uid &&
        (course.value.teacher == null || course.value.teacher.isEmpty));
    editable.value = (HomeController.mainUser.uid == course.value.owner &&
        course.value.status == CourseStatus.upcoming);
    if (course.value.timeType == TimeType.periodTime) {
      timeOverall = '--' + 'hh'.tr + ' (${course.value.periods.length} buổi)';
    } else {
      timeOverall = '--' + 'hh'.tr;
    }
    isLoading.value = false;
  }

  MyCourseDetailController(Course course) {
    this.course = course.obs;
  }

  joinCourse() async {
    isJoining.value = true;
    course.value.learners.add(HomeController.mainUser.uid);
    await CourseService.instance.updateLearnners(course.value);
    var user = await UserService.instance.getUser(HomeController.mainUser.uid);
    learners.insert(0, user);
    isJoining.value = false;
    joinable.value = false;
    requestable.value = false;
  }
}
