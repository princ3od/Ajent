import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/services/course_service.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TeachingController extends GetxController {
  var courses = <Course>[].obs;
  var currentIndex = 1.obs;
  var isFetching = false.obs;
  List<Course> allCourses;
  final RefreshController refreshController = RefreshController();

  @override
  onInit() async {
    super.onInit();
  }

  fetchCourses() async {
    print('fetching');
    isFetching.value = true;
    allCourses = await CourseService.instance
        .getUserTeachingCourse(HomeController.mainUser.uid);
    print('fetch done!');
    print(allCourses.length);
    showCourses();
    refreshController.refreshCompleted();
    isFetching.value = false;
  }

  onTabChanged(int index) {
    currentIndex.value = index;
    showCourses();
  }

  showCourses() async {
    courses.clear();
    for (var course in allCourses) {
      //print(course.name + " " + course.status.toString());
      if (course.status == CourseStatus.values[currentIndex.value]) {
        courses.add(course);
      }
    }
  }
}
