import 'package:ajent/app/data/services/AuthenticService.dart';
import 'package:ajent/app/modules/auth/auth_controller.dart';
import 'package:ajent/routes/pages.dart';
import 'package:get/get.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class SplashController extends GetxController {
  var isLoading = true.obs;
  var loadInfor = "".obs;
  @override
  void onInit() async {
    super.onInit();
    intilizeFirebase();
  }

  intilizeFirebase() async {
    loadInfor.value = "Khởi tạo kết nối với server...";
    await AuthenticService.instance.initializeFirebase();
    loadInfor.value = "Một chút nữa...";
    await Future.delayed(Duration(milliseconds: 200));
    timeDilation = 2.5;
    loadInfor.value = "Xong rồi!";
    isLoading.value = false;
    await Future.delayed(Duration(milliseconds: 200));
    if (AuthenticService.instance.getCurrentUser() == null) {
      AuthController.loginType = AuthenticService.instance.getLoginType();
      await Get.offNamed(Routes.WELCOME);
    } else {
      loadInfor.value = "Chào mừng bạn quay lại!";
      await Future.delayed(Duration(milliseconds: 300));
      await Get.offNamed(Routes.HOME);
    }
  }
}
