import 'package:ajent/app/data/services/AuthenticService.dart';
import 'package:ajent/routes/pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isSigningIn = false.obs;
  loginWithGoogle() async {
    isSigningIn.value = true;
    User user = await AuthenticService.instance.signInWithGoogle();
    if (user != null) {
      isSigningIn.value = false;
      Get.offAllNamed(Routes.HOME);
    } else
      Get.snackbar(
          "Đăng nhập thất bại", "Đã có lỗi xảy ra trong quá trình đăng nhập.");
    isSigningIn.value = false;
  }

  signOutGoogle() async {
    await AuthenticService.instance.signOutGoogle();
    Get.offAllNamed(Routes.WELCOME);
  }

  loginWithFacebook() async {
    isSigningIn.value = true;
    User user = await AuthenticService.instance.signInWithFacebook();
    if (user != null) {
      isSigningIn.value = false;
      Get.offAllNamed(Routes.HOME);
    } else
      Get.snackbar(
          "Đăng nhập thất bại", "Đã có lỗi xảy ra trong quá trình đăng nhập.");
    isSigningIn.value = false;
  }

  signOutFacebook() async {
    await AuthenticService.instance.signOutFacebook();
    Get.offAllNamed(Routes.WELCOME);
  }

  loginWithPhone() async {
    //
  }
}
