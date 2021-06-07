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
  var isSendingOTP = false.obs;
  var isVerifing = false.obs;
  var verificationID = "".obs;
  TextEditingController txtPhoneNumber = TextEditingController();
  TextEditingController txtCode = TextEditingController();

  static LoginType loginType;

  loginWithGoogle() async {
    isSigningIn.value = true;
    User user = await AuthenticService.instance.signInWithGoogle();
    if (user != null) {
      await loadUser(user);
      Get.offAllNamed(Routes.HOME);
      isSigningIn.value = false;
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
        user.displayName ?? "Ajent user",
        DateTime.now(),
        Gender.male,
        "",
        user.phoneNumber ?? "",
        user.email ?? "",
        user.photoURL ?? "",
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
        _signOutPhone();
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
      await loadUser(user);
      loginType = LoginType.withFacebook;
      Get.offAllNamed(Routes.HOME);
      isSigningIn.value = false;
      HomeController.checkUserUpdateInfo();
    } else
      Get.snackbar(
          "Đăng nhập thất bại", "Đã có lỗi xảy ra trong quá trình đăng nhập.");
    isSigningIn.value = false;
  }

  static _signOutFacebook() async {
    await AuthenticService.instance.signOutFacebook();
  }

  loginWithPhone() async {
    isSendingOTP.value = true;
    if (txtPhoneNumber.text.startsWith("0"))
      txtPhoneNumber.text = txtPhoneNumber.text.substring(1);
    if (!txtPhoneNumber.text.contains("+84"))
      txtPhoneNumber.text = "+84" + txtPhoneNumber.text;
    await Future.delayed(Duration(seconds: 1));
    await AuthenticService.instance.verifyPhoneNumber(
      txtPhoneNumber.text,
      _onPhoneVerified,
      _onFailed,
      _onCodeSent,
      _onTimeOut,
    );
  }

  static _signOutPhone() async {
    await FirebaseAuth.instance.signOut();
  }

  verifyCode() async {
    isVerifing.value = true;
    User user = await AuthenticService.instance
        .signInByPhone(verificationID.value, txtCode.text);
    if (user != null) {
      await loadUser(user);
      Get.offAllNamed(Routes.HOME);
      isVerifing.value = false;
      HomeController.checkUserUpdateInfo();
    } else {
      Get.snackbar(
          "Đăng nhập thất bại", "Mã OTP không hợp lệ, vui lòng kiểm tra lại.");
      await loadUser(user);
    }
  }

  _onPhoneVerified() {
    //veri
  }

  _onCodeSent(String _verificationID) {
    isSendingOTP.value = false;
    verificationID.value = _verificationID;
    Get.snackbar("Thông báo", "Mã xác nhận đã được gửi!");
    Get.offAndToNamed(Routes.VERIFICATION, arguments: txtPhoneNumber.text);
  }

  _onFailed() {
    isSendingOTP.value = false;
    Get.snackbar("Lỗi", "Không thể gửi mã xác nhận!");
  }

  _onTimeOut(String _verificationID) {
    isSendingOTP.value = false;
    verificationID.value = _verificationID;
  }
}
