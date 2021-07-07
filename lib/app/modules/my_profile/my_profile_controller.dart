import 'dart:io';
import 'package:ajent/app/data/models/Degree.dart';
import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/services/storage_service.dart';
import 'package:ajent/app/data/services/user_service.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ajent/core/utils/file_utils.dart';

class MyProfileController extends GetxController {
  var tabIndex = 0.obs;
  var ajentUser = HomeController.mainUser.obs;
  var dropdownValue = ''.obs;
  var startDate = HomeController.mainUser.birthDay.obs;
  var ajenGender = HomeController.mainUser.gender.obs;
  var ajenDegree = HomeController.mainUser.degrees.obs;

  TextEditingController txtName = TextEditingController();
  TextEditingController txtMail = TextEditingController();
  TextEditingController txtSchool = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtMajor = TextEditingController();
  TextEditingController txtBio = TextEditingController();

  TextEditingController txtTitle;
  TextEditingController txtDescription;

  UserService userService = UserService.instance;
  StorageService storageService = StorageService.instance;

  var loadDegree = false.obs;
  var loadStudent = false.obs;
  var isUpdatingAvatar = false.obs;
  var isUpdatingInfo = false.obs;

  var isUploadDegreeImage;
  var imageDegreeUrl;
  var imageDegreeFile;
  @override
  onInit() {
    super.onInit();
    txtName.text = ajentUser.value.name;
    txtMail.text = ajentUser.value.mail;
    txtSchool.text = ajentUser.value.schoolName;
    txtPhone.text = ajentUser.value.phone;
    txtMajor.text = ajentUser.value.major;
    txtBio.text = ajentUser.value.bio;
    dropdownValue.value = ajentUser.value.educationLevel;
  }

  loadUserDegree() async {
    ajentUser.value.degrees = await userService.getDegrees(ajentUser.value.uid);
    ajenDegree.value = ajentUser.value.degrees;
    loadDegree.value = true;
  }

  Future<void> onLongPressDegreeCard(Degree degree) async {
    await Get.defaultDialog(
      title: "Warning".tr,
      content: Text(
        "Do you want to delete?".tr,
      ),
      cancel: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: primaryColor,
        ),
        onPressed: () {
          Get.back();
        },
        child: Text('Cancel'),
      ),
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: primaryColor,
        ),
        onPressed: () async {
          await userService.delDegree(HomeController.mainUser.uid, degree.id);
          await loadUserDegree();
          Get.back();
          Get.snackbar("Success".tr, "Successfully deleted".tr);
        },
        child: Text('Confirm'.tr),
      ),
    );
  }

  Future<void> onChangeAvatar() async {
    isUpdatingAvatar.value = true;
    File file = await FileUtilitiy.getImage();
    String returnUrl;
    if (file != null) {
      returnUrl =
          await this.userService.updateUserAvatar(ajentUser.value, file);
      if (returnUrl != null) {
        ajentUser.update((val) {
          val.avatarUrl = returnUrl;
        });
        print("avatar is updated!");
      } else {
        print("updating avatar failed!");
      }
    }
    isUpdatingAvatar.value = false;
  }

  Future<void> _onTakeImage() async {
    imageDegreeFile.value = await FileUtilitiy.getImage();
  }

  Future<void> _onUploadImage() async {
    isUploadDegreeImage.value = true;

    if (imageDegreeFile.value != null) {
      imageDegreeUrl.value = await storageService.uploadImage(
          imageDegreeFile.value, HomeController.mainUser.uid);
    }
    isUploadDegreeImage.value = false;
  }

  Future<void> _onUpdateUserDegree(BuildContext context) async {
    bool success = false;
    var _title = txtTitle.text;
    var _description = txtDescription.text;
    var _imageDegreeUrl = imageDegreeUrl.value;
    if (_title == "" || _description == "" || _imageDegreeUrl == "") {
      Get.snackbar("error".tr, "check_course_info_warning".tr);
      return;
    }
    var degree = Degree(
        imageUrl: _imageDegreeUrl, title: _title, description: _description);
    success = await userService.addDegree(HomeController.mainUser.uid, degree);
    if (!success) {
      Get.snackbar("error".tr, "Server is busy, please try again later".tr);
    } else {
      loadDegree.value = false;
      await loadUserDegree();

      Navigator.pop(context);
      Get.snackbar("Success".tr, "Your profile has been updated".tr);
    }
  }

  Future<void> onPressSave(BuildContext context) async {
    await _onUploadImage();
    await _onUpdateUserDegree(context);
  }

  Future<bool> updateInformation() async {
    isUpdatingInfo.value = true;
    AjentUser ajentUser = HomeController.mainUser;
    ajentUser.birthDay = startDate.value;
    ajentUser.name = txtName.text;
    ajentUser.mail = txtMail.text;
    ajentUser.schoolName = txtSchool.text;
    ajentUser.phone = txtPhone.text;
    ajentUser.educationLevel = dropdownValue.value;
    ajentUser.bio = txtBio.text;
    bool success = await this.userService.updateInfo(ajentUser);
    if (success) {
      Get.snackbar("Success".tr, "Infomation updated".tr);
    } else {
      print("updating infor failed!");
      Get.snackbar("Lỗi", "Cập nhật thất bại, vui lòng thử lại sau!");
    }
    isUpdatingInfo.value = false;
    return success;
  }

  showAddDegreeSheet(BuildContext context) async {
    resetDegreeBottomSheet();
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      )),
      context: context,
      builder: (context) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: Get.height * 0.7,
              child: Center(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 0),
                          child: Center(
                              child: CircleAvatar(
                            backgroundColor: Colors.white54,
                            radius: 60 * 1.0,
                            child: ClipOval(
                              child: Obx(
                                () => imageDegreeFile.value.path == ""
                                    ? Image.asset(
                                        'assets/images/ajent_logo.png',
                                        width: 85,
                                        height: 85,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        imageDegreeFile.value,
                                        width: 85,
                                        height: 85,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text('Photo'.tr,
                              style: GoogleFonts.nunitoSans(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text('Title'.tr,
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        TextField(
                          controller: txtTitle,
                          decoration: primaryTextFieldDecoration,
                          cursorColor: primaryColor,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text('Detail infomation'.tr,
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        TextField(
                          controller: txtDescription,
                          decoration: primaryTextFieldDecoration,
                          cursorColor: primaryColor,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                await onPressSave(context);
                              },
                              child: Text("Save".tr),
                              style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel".tr),
                              style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        width: 95,
                        height: 100,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: ClipOval(
                            child: Container(
                              width: 30,
                              height: 30,
                              color: Colors.grey.shade400.withAlpha(220),
                              child: InkWell(
                                splashColor: primaryColor,
                                customBorder: CircleBorder(),
                                onTap: () async {
                                  await _onTakeImage();
                                },
                                child: Obx(
                                  () => isUploadDegreeImage.value == false
                                      ? Icon(
                                          Icons.camera_alt_outlined,
                                          size: 20,
                                        )
                                      : CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Color(0xff01BCD4)),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void onPressedStudentCancel(BuildContext context) {
    _showMyDialog(context: context, title: Text('Warning'.tr), children: [
      Text('Are you sure to quit?'.tr)
    ], actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        child: Text('yes'.tr),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('no'.tr),
      )
    ]);
  }

  Future<void> _showMyDialog(
      {BuildContext context,
      Widget title,
      List<Widget> children,
      List<Widget> actions}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: title,
          content: SingleChildScrollView(
            child: ListBody(
              children: children,
            ),
          ),
          actions: actions,
        );
      },
    );
  }

  List<String> createTags() {
    List<String> tags = [];
    var container = HomeController.mainUser.major.split(" ");
    container.forEach((item) {
      tags.add(item.replaceAll(new RegExp(r"\s+\b|\b\s"), ""));
    });
    tags.removeWhere((element) => (element == "" || element == " "));
    return tags;
  }

  void resetDegreeBottomSheet() {
    isUploadDegreeImage = false.obs;
    txtTitle = TextEditingController();
    txtDescription = TextEditingController();
    imageDegreeUrl = "".obs;
    imageDegreeFile = File("").obs;
  }
}
