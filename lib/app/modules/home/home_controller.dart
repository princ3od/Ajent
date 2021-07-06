import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/models/notification_model.dart';
import 'package:ajent/app/data/services/course_service.dart';
import 'package:ajent/app/data/services/notification_service.dart';
import 'package:ajent/app/data/services/user_service.dart';
import 'package:ajent/app/modules/learning/learning_controlller.dart';
import 'package:ajent/app/modules/notification/notification_controller.dart';
import 'package:ajent/app/modules/request/request_controller.dart';
import 'package:ajent/app/modules/teaching/teaching_controller.dart';
import 'package:ajent/core/utils/enum_converter.dart';
import 'package:ajent/routes/pages.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  var tabpageIndex = 0.obs;
  var isOnMain = true.obs;
  var childTabIndex = 0.obs;
  var targetPage = 0;
  var needChangeNavigator = true;
  var newNotification = false.obs;
  var newMessage = false.obs;
  PageController pageController = PageController();
  final RefreshController refreshController = RefreshController();

  LearningController _learningController;
  TeachingController _teachingController;
  var courses = <Course>[].obs;
  var isFetching = false.obs;
  var weekTabIndex = 0.obs;
  List<Course> allCourses = [];
  static AjentUser mainUser;
  static String langCode;
  @override
  onInit() async {
    super.onInit();
    isFetching.value = true;
    NotificationService.instance.onNotificationOpenApp((message) async {
      NotificationAction action =
          EnumConverter.stringToNotificationAction(message.data['action']);
      switch (action) {
        case NotificationAction.openCourse:
          Course course =
              await CourseService.instance.getCourse(message.data['courseId']);
          Get.toNamed(Routes.MYCOURSEDETAIL, arguments: course);
          break;
        case NotificationAction.openMyRequest:
          await Get.toNamed(Routes.REQUEST_VIEW);
          Get.find<RequestController>().tabIndex.value = 0;
          break;
        case NotificationAction.openTheirRequest:
          Get.toNamed(Routes.REQUEST_VIEW);
          break;
        case NotificationAction.openChatting:
          AjentUser user =
              await UserService.instance.getUser(message.data['partner']);
          Get.toNamed(Routes.CHATTING, arguments: user);
          break;
      }
    });
    NotificationService.instance.onNotication((message) async {
      NotificationAction action =
          EnumConverter.stringToNotificationAction(message.data['action']);
      if (action != NotificationAction.openChatting) {
        newNotification.value = true;
        Get.find<NotificationController>().fetch();
      } else {
        newMessage.value = true;
      }
    });
    weekTabIndex.value = DateTime.now().weekday - 1;
    _learningController = Get.find<LearningController>();
    _teachingController = Get.find<TeachingController>();
    await _learningController.fetchCourses();
    await _teachingController.fetchCourses();
    allCourses.addAll(_learningController.allCourses);
    allCourses.addAll(_teachingController.allCourses);
    allCourses.removeWhere((element) => element.status != CourseStatus.ongoing);
    courses.removeWhere((element) => !element.isInCalendar(weekTabIndex.value));
    loadCourses();
    isFetching.value = false;
  }

  fetch() async {
    isFetching.value = true;
    await _learningController.fetchCourses();
    await _teachingController.fetchCourses();
    allCourses.clear();
    allCourses.addAll(_learningController.allCourses);
    allCourses.addAll(_teachingController.allCourses);
    allCourses.removeWhere((element) => element.status != CourseStatus.ongoing);
    refreshController.refreshCompleted();
    loadCourses();
    isFetching.value = false;
  }

  loadCourses() {
    courses.clear();
    courses.addAll(allCourses);
    courses.removeWhere((element) => !element.isInCalendar(weekTabIndex.value));
    courses.sort((a, b) =>
        a.timeInCalendar.startTime.compareTo(b.timeInCalendar.startTime));
    courses.refresh();
  }

  oncChildTabChanged(int index) {
    childTabIndex.value = index;
  }

  onPageChanged(int index) {
    if (index == targetPage && needChangeNavigator) {
      tabpageIndex.value = index;
      switch (index) {
        case 1:
          Get.find<LearningController>().showCourses();
          break;
        default:
          break;
      }
    }
  }

  onBottomNavigationBarChanged(int index) async {
    tabpageIndex.value = index;
    needChangeNavigator = false;
    await pageController.animateToPage(
      tabpageIndex.value,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    switch (index) {
      case 1:
        _learningController.showCourses();
        break;
      case 2:
        _teachingController.showCourses();
        break;
      case 3:
        newNotification.value = false;
        break;
      default:
        break;
    }
    targetPage = index;
    needChangeNavigator = true;
  }

  static checkUserUpdateInfo() {
    if (!HomeController.mainUser.isInfoUpdated()) {
      print("cc");
      Get.dialog(AlertDialog(
        title: Text('update_info_dialog_title'.tr),
        content: Text('update_info_dialog_content'.tr),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
                Get.toNamed(Routes.PROFILE);
              },
              child: Text('update_info_dialog_button'.tr)),
        ],
      ));
    }
  }
}

extension TimeOfDayExtension on TimeOfDay {
  int compareTo(TimeOfDay other) {
    if (this.hour < other.hour) return -1;
    if (this.hour > other.hour) return 1;
    if (this.minute < other.minute) return -1;
    if (this.minute > other.minute) return 1;
    return 0;
  }
}
