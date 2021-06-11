import 'dart:async';

import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/models/Person.dart';

import 'package:ajent/app/data/services/authenctic_service.dart';
import 'package:ajent/app/data/services/user_service.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/routes/pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_receiver/sms_receiver.dart';

class AuthController extends GetxController {
  var isSigningIn = false.obs;
  var isSendingOTP = false.obs;
  var isVerifing = false.obs;
  var verificationID = "".obs;
  var timeOut = 45.obs;
  TextEditingController txtPhoneNumber = TextEditingController();
  TextEditingController txtCode = TextEditingController();
  SmsReceiver _smsReceiver;
  static LoginType loginType;
  Timer _timerTimeOut;
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
          'notification_login_fail'.tr, 'notification_login_fail_content'.tr);
    isSigningIn.value = false;
  }

  static Future loadUser(User user) async {
    loginType = LoginType.withGoogle;
    bool isExist = await UserService.instance.isUserExisted(user);
    if (!isExist) {
      AjentUser ajentUser = AjentUser(
        user.uid,
        user.displayName ?? 'default_name'.tr,
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
    } else {
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
      await Get.offAllNamed(Routes.HOME);
      isSigningIn.value = false;
      HomeController.checkUserUpdateInfo();
    } else
      Get.snackbar(
          'notification_login_fail'.tr, 'notification_login_fail_content'.tr);
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
    await AuthenticService.instance.verifyPhoneNumber(
      txtPhoneNumber.text,
      _onPhoneVerified,
      _onFailed,
      _onCodeSent,
      _onTimeOut,
    );
  }

  resendOTP() async {
    isSendingOTP.value = true;
    await AuthenticService.instance.verifyPhoneNumber(
      txtPhoneNumber.text,
      null,
      _onFailed,
      (_verificationID) {
        isSendingOTP.value = false;
        Get.snackbar('notification'.tr, 'otp_resend'.tr);
        timeOut.value = 45;
        _timerTimeOut = Timer.periodic(Duration(seconds: 1), (timer) {
          if (timeOut.value > 0) {
            timeOut.value--;
          } else {
            timeOut.value = 0;
            _timerTimeOut.cancel();
          }
        });
      },
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
      await Get.offAllNamed(Routes.HOME);
      isVerifing.value = false;
      HomeController.checkUserUpdateInfo();
    } else {
      Get.snackbar('notification_login_fail'.tr, 'otp_invalid'.tr);
      isVerifing.value = false;
    }
  }

  _onPhoneVerified() {
    //veri
  }

  _onCodeSent(String _verificationID) async {
    isSendingOTP.value = false;
    verificationID.value = _verificationID;
    Get.snackbar('notification'.tr, 'otp_send'.tr);
    Get.offAndToNamed(Routes.VERIFICATION, arguments: txtPhoneNumber.text);
    _smsReceiver = SmsReceiver((msg) {
      print('msg coming');
      var data = msg.split(" ");
      print(msg);
      print(data[6]);
      txtCode.text = data[6];
    });
    _smsReceiver.startListening();
    timeOut.value = 45;
    _timerTimeOut = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeOut.value > 0) {
        timeOut.value--;
      } else {
        timeOut.value = 0;
        _timerTimeOut.cancel();
      }
    });
  }

  _onFailed() {
    isSendingOTP.value = false;
    Get.snackbar('error'.tr, 'unable_send_otp'.tr);
  }

  _onTimeOut(String _verificationID) {
    isSendingOTP.value = false;
    print('timeout fail');
    verificationID.value = _verificationID;
  }
}
