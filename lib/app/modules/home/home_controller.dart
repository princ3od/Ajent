import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/models/notification_model.dart';
import 'package:ajent/app/data/services/course_service.dart';
import 'package:ajent/app/data/services/notification_service.dart';
import 'package:ajent/app/data/services/user_service.dart';
import 'package:ajent/app/modules/learning/learning_controlller.dart';
import 'package:ajent/app/modules/notification/notification_controller.dart';
import 'package:ajent/app/modules/request/request_controller.dart';
import 'package:ajent/core/utils/enum_converter.dart';
import 'package:ajent/routes/pages.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeController extends GetxController {
  var tabpageIndex = 0.obs;
  var isOnMain = true.obs;
  var childTabIndex = 0.obs;
  var targetPage = 0;
  var needChangeNavigator = true;
  var newNotification = false.obs;
  var newMessage = false.obs;
  PageController pageController = PageController();
  PanelController panelController = PanelController();
  static AjentUser mainUser;
  @override
  onInit() {
    super.onInit();
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
        Get.find<LearningController>().showCourses();
        break;
      case 2:
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
