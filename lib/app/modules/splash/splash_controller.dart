import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/models/notification_model.dart';
import 'package:ajent/app/data/services/authenctic_service.dart';
import 'package:ajent/app/data/services/course_service.dart';
import 'package:ajent/app/data/services/notification_service.dart';
import 'package:ajent/app/data/services/user_service.dart';
import 'package:ajent/app/modules/auth/auth_controller.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/app/modules/request/request_controller.dart';
import 'package:ajent/core/utils/enum_converter.dart';
import 'package:ajent/core/values/lang/localization_service.dart';
import 'package:ajent/routes/pages.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  var isLoading = true.obs;
  @override
  void onInit() async {
    super.onInit();
    intilizeFirebase();
  }

  intilizeFirebase() async {
    await AuthenticService.instance.initializeFirebase();

    final user = AuthenticService.instance.getCurrentUser();
    var _pref = await SharedPreferences.getInstance();
    HomeController.langCode = _pref.getString('lang');
    if (HomeController.langCode == null) {
      HomeController.langCode = LocalizationService.locale.languageCode;
      await _pref.setString('lang', LocalizationService.locale.languageCode);
    } else {
      LocalizationService.changeLocale(HomeController.langCode);
    }
    if (user == null) {
      Get.offNamed(Routes.WELCOME);
    } else {
      AuthController.loginType = AuthenticService.instance.getLoginType();
      print(AuthController.loginType);
      await AuthController.loadUser(user);
      RemoteMessage notification =
          await NotificationService.instance.getInitialNotification();
      if (notification == null) {
        Get.offNamed(Routes.HOME);
        HomeController.checkUserUpdateInfo();
        isLoading.value = false;
      } else {
        Get.offNamed(Routes.HOME);
        NotificationAction action = EnumConverter.stringToNotificationAction(
            notification.data['action']);
        isLoading.value = false;
        switch (action) {
          case NotificationAction.openCourse:
            Course course = await CourseService.instance
                .getCourse(notification.data['courseId']);
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
            AjentUser user = await UserService.instance
                .getUser(notification.data['partner']);
            Get.toNamed(Routes.CHATTING, arguments: user);
            break;
        }
      }
    }
  }
}
