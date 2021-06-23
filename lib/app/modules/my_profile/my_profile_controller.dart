import 'dart:io';
import 'package:ajent/app/data/models/Degree.dart';
import 'package:ajent/app/data/models/Student.dart';
import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/services/storage_service.dart';
import 'package:ajent/app/data/services/user_service.dart';
import 'package:ajent/app/global_widgets/user_avatar.dart';
import 'package:ajent/app/modules/chat/widgets/full_image_page.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class MyProfileController extends GetxController {
  var tabIndex = 0.obs;
  var ajentUser = HomeController.mainUser.obs;
  var dropdownValue = ''.obs;
  var startDate = DateTime.now().obs;
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

  var isUploadDegreeImage = false.obs;
  var imageDegreeUrl = "".obs;
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
    loadDegree.value = true;
  }

  Future<void> onChangeAvatar() async {
    isUpdatingAvatar.value = true;
    final picker = ImagePicker();
    var file = await _getImage(picker);
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

  Future<File> _getImage(ImagePicker picker) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      print('No image selected.');
      return null;
    }
  }

  Future<void> _onUploadImage() async {
    isUploadDegreeImage.value = true;
    var imagePicker = new ImagePicker();
    var pickedFile = await _getImage(imagePicker);
    if (pickedFile != null) {
      imageDegreeUrl.value = await storageService.uploadImage(
          pickedFile, HomeController.mainUser.uid);
    }
    isUploadDegreeImage.value = false;
  }

  Future<void> _onUpdateUserDegree(BuildContext context) async {
    bool success = false;
    var _title = txtTitle.text;
    var _description = txtDescription.text;
    var _imageDegreeUrl = imageDegreeUrl.value;
    if (_title == "" || _description == "" || _imageDegreeUrl == "") {
      Get.snackbar("Lỗi", "Kiểm tra dữ liệu đã nhập,và thử lại!");
      return;
    }
    var degree = Degree(
        imageUrl: _imageDegreeUrl, title: _title, description: _description);
    success = await userService.addDegree(HomeController.mainUser.uid, degree);
    if (!success) {
      Get.snackbar("Lỗi", "Sever hiện tại đang bận, vui lòng thử lại sau.");
    } else {
      await loadUserDegree();
      ajenDegree.value = HomeController.mainUser.degrees;
      Navigator.pop(context);
      Get.snackbar("Thông báo", "Hồ sơ của bạn, đã được cập nhật.");
    }
  }

  Future<bool> updateInformation() async {
    isUpdatingInfo.value = true;
    AjentUser ajentUser = HomeController.mainUser;
    ajentUser.name = txtName.text;
    ajentUser.mail = txtMail.text;
    ajentUser.schoolName = txtSchool.text;
    ajentUser.phone = txtPhone.text;
    ajentUser.educationLevel = dropdownValue.value;
    ajentUser.bio = txtBio.text;
    bool success = await this.userService.updateInfo(ajentUser);
    if (success) {
      Get.snackbar("Thông báo", "Đã cập nhật thông tin thành công!");
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
      context: context,
      builder: (context) {
        return SingleChildScrollView(
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
                              () => FadeInImage.assetNetwork(
                                fadeInDuration: Duration(milliseconds: 200),
                                fadeOutDuration: Duration(milliseconds: 180),
                                placeholder: "assets/images/ajent_logo.png",
                                image: imageDegreeUrl.value,
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
                        child: Text('Ảnh chụp',
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
                        child: Text('Tiểu đề',
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
                        child: Text('Thông tin chi tiết',
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
                              await _onUpdateUserDegree(context);
                            },
                            child: Text("Save"),
                            style: ElevatedButton.styleFrom(
                              primary: primaryColor,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"),
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
                                await _onUploadImage();
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
        );
      },
    );
  }

  void onPressedStudentCancel(BuildContext context) {
    _showMyDialog(context: context, title: Text('Warning!'), children: [
      Text('Are you sure to quit?')
    ], actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        child: Text('Yes'),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('No'),
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
    imageDegreeUrl = "".obs;
    txtTitle = TextEditingController();
    txtDescription = TextEditingController();
    isUploadDegreeImage = false.obs;
    imageDegreeUrl = "".obs;
  }
}
