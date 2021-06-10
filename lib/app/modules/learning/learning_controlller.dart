import 'package:ajent/app/data/models/Course.dart';
import 'package:ajent/app/data/services/course_service.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:get/get.dart';

class LearningController extends GetxController {
  var courses = <Course>[].obs;
  var currentIndex = 1.obs;
  List<Course> allCourses;
  fetchCourses() async {
    print('fetching');
    allCourses = await CourseService.instance
        .getUserLearningCourse(HomeController.mainUser.uid);
    print('fetch done!');
    showCourses();
  }

  onTabChanged(int index) {
    currentIndex.value = index;
    print(CourseStatus.values[index]);
    showCourses();
    print(courses.length);
    //
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
