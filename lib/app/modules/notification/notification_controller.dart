import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/models/notification_model.dart';
import 'package:ajent/app/data/services/course_service.dart';
import 'package:ajent/app/data/services/notification_service.dart';
import 'package:ajent/app/data/services/user_service.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/app/modules/request/request_controller.dart';
import 'package:ajent/routes/pages.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationController extends GetxController {
  AjentUser user = HomeController.mainUser;
  var isLoading = false.obs;
  var notifications = <NotificationModel>[].obs;

  var refreshController = RefreshController();
  @override
  onInit() {
    super.onInit();
    fetch();
  }

  fetch() async {
    isLoading.value = true;
    notifications.value =
        await NotificationService.instance.getAllNotifications(user.uid);
    refreshController.refreshCompleted();
    isLoading.value = false;
  }

  open(NotificationModel notification) async {
    switch (notification.action) {
      case NotificationAction.openCourse:
        Course course =
            await CourseService.instance.getCourse(notification.courseId);
        Get.toNamed(Routes.MYCOURSEDETAIL, arguments: course);
        break;
      case NotificationAction.openMyRequest:
        await Get.toNamed(Routes.REQUEST_VIEW);
        Get.find<RequestController>().tabIndex.value = 0;
        break;
      case NotificationAction.openTheirRequest:
        Get.toNamed(Routes.REQUEST_VIEW);
        Get.find<RequestController>().tabIndex.value = 1;
        break;
      case NotificationAction.openChatting:
        break;
    }
  }
}
