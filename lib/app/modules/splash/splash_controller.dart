import 'package:ajent/app/data/services/authenctic_service.dart';
import 'package:ajent/app/modules/auth/auth_controller.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/routes/pages.dart';
import 'package:get/get.dart';

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
    if (user == null) {
      Get.offNamed(Routes.WELCOME);
    } else {
      AuthController.loginType = AuthenticService.instance.getLoginType();
      print(AuthController.loginType);
      await AuthController.loadUser(user);
      isLoading.value = false;
      Get.offNamed(Routes.HOME);
      HomeController.checkUserUpdateInfo();
    }
  }
}
