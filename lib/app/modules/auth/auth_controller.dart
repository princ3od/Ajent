import 'package:ajent/app/data/models/AjentUser.dart';
import 'package:ajent/app/data/models/Person.dart';

import 'package:ajent/app/data/services/authenctic_service.dart';
import 'package:ajent/app/data/services/user_service.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/routes/pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isSigningIn = false.obs;
  var verificationID = "".obs;
  TextEditingController txtPhoneNumber = TextEditingController();
  TextEditingController txtCode = TextEditingController();

  static LoginType loginType;

  loginWithGoogle() async {
    isSigningIn.value = true;
    User user = await AuthenticService.instance.signInWithGoogle();
    if (user != null) {
      await loadUser(user);
      isSigningIn.value = false;
      Get.offAllNamed(Routes.HOME);
      HomeController.checkUserUpdateInfo();
    } else
      Get.snackbar(
          "Đăng nhập thất bại", "Đã có lỗi xảy ra trong quá trình đăng nhập.");
    isSigningIn.value = false;
  }

  static Future loadUser(User user) async {
    loginType = LoginType.withGoogle;
    bool isExist = await UserService.instance.isUserExisted(user);
    if (!isExist) {
      AjentUser ajentUser = AjentUser(
        user.uid,
        user.displayName,
        DateTime.now(),
        Gender.male,
        "",
        user.phoneNumber,
        user.email,
        user.photoURL,
        "",
        "",
        "",
        "",
      );
      HomeController.mainUser = await UserService.instance.addUser(ajentUser);
      Get.snackbar("Đăng nhập thành công",
          "Chào mừng ${user.displayName} đến với Ajent.");
    } else {
      print("old");
      HomeController.mainUser = await UserService.instance.getUser(user.uid);
    }
  }

  static signOut() {
    switch (loginType) {
      case LoginType.withGoogle:
        _signOutGoogle();
        break;
      case LoginType.withFacebook:
        _signOutFacebook();
        break;
      case LoginType.byPhone:
        break;
      default:
        break;
    }
    Get.offAllNamed(Routes.WELCOME);
  }

  static _signOutGoogle() async {
    await AuthenticService.instance.signOutGoogle();
    await FirebaseAuth.instance.signOut();
  }

  loginWithFacebook() async {
    isSigningIn.value = true;
    User user = await AuthenticService.instance.signInWithFacebook();
    if (user != null) {
      isSigningIn.value = false;
      loginType = LoginType.withFacebook;
      Get.offAllNamed(Routes.HOME);
    } else
      Get.snackbar(
          "Đăng nhập thất bại", "Đã có lỗi xảy ra trong quá trình đăng nhập.");
    isSigningIn.value = false;
  }

  static _signOutFacebook() async {
    await AuthenticService.instance.signOutFacebook();
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
