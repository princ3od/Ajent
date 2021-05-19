import 'package:ajent/app/data/services/AuthenticService.dart';
import 'package:ajent/routes/pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isSigningIn = false.obs;
  var verificationID = "".obs;
  TextEditingController txtPhoneNumber = TextEditingController();
  TextEditingController txtCode = TextEditingController();
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
    await AuthenticService.instance.verifyPhoneNumber(
      txtPhoneNumber.text,
      _onPhoneVerified,
      _onFailed,
      _onCodeSent,
      _onTimeOut,
    );
  }

  verifyCode() async {
    User user = await AuthenticService.instance
        .signInByPhone(verificationID.value, txtCode.text);
    if (user != null) {
      Get.offAllNamed(Routes.HOME);
    } else
      Get.snackbar(
          "Đăng nhập thất bại", "Đã có lỗi xảy ra trong quá trình đăng nhập.");
  }

  _onPhoneVerified() {
    //Get.offAllNamed(Routes.HOME);
  }

  _onCodeSent(String _verificationID) {
    verificationID.value = _verificationID;
    Get.snackbar("Thông báo", "Mã xác nhận đã được gửi!");
  }

  _onFailed() {
    Get.snackbar("Lỗi", "Không thể gửi mã xác nhận!");
  }

  _onTimeOut(String _verificationID) {
    verificationID.value = _verificationID;
    Get.snackbar("Timeout", "abc");
  }
}
