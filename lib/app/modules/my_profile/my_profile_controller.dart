import 'dart:io';
import 'package:ajent/app/data/models/Degree.dart';
import 'package:ajent/app/data/models/Student.dart';
import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/services/storage_service.dart';
import 'package:ajent/app/data/services/user_service.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MyProfileController extends GetxController {
  var tabIndex = 0.obs;
  var ajentUser = HomeController.mainUser.obs;
  var dropdownValue = ''.obs;
  var startDate = DateTime.now().obs;
  var ajenGender = HomeController.mainUser.gender.obs;

  TextEditingController txtName = TextEditingController();
  TextEditingController txtMail = TextEditingController();
  TextEditingController txtSchool = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtMajor = TextEditingController();
  TextEditingController txtBio = TextEditingController();

  UserService userService = UserService.instance;
  StorageService storageService = StorageService.instance;

  var loadDegree = false.obs;
  var loadStudent = false.obs;
  var isUpdatingAvatar = false.obs;
  var isUpdatingInfo = false.obs;
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

  // loadUserStudent() async {
  //   ajentUser.value.students =
  //       await userService.getStudents(ajentUser.value.uid);
  //   loadStudent.value = true;
  // }

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
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      print('No image selected.');
      return null;
    }
  }

  Future<void> onClosedDiplomaOverlay(BuildContext context) async {
    // image.value = File('');
    // degrees.value =
    //     await this.userService.getDegrees(HomeController.mainUser.uid);
    // Navigator.of(context).pop();
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
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: Get.height,
          child: Center(
            child: Text('add degree here'),
          ),
        );
      },
    );
  }

  showAddStudentSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: Get.height,
          child: Center(
            child: Text('add student here'),
          ),
        );
      },
    );
  }

  bool isAvailableInputInfo() {
    // List<String> items = [
    //   name.value,
    //   email.value,
    //   bio.value,
    //   school.value,
    //   educationLevel.value,
    //   major.value,
    //   phone.value,
    //   dropdownValue.value,
    // ];
    // for (int i = 0; i < items.length; i++) {
    //   if (items[i] == null || items[i] == '') {
    //     return false;
    //   }
    // }
    return true;
  }

  bool isAvaiableDegreeInfo() {
    // List<String> items = [
    //   image.value.path,
    //   description.value,
    //   title.value,
    // ];

    // for (int i = 0; i < items.length; i++) {
    //   if (items[i] == null || items[i] == '') {
    //     return false;
    //   }
    // }
    // return true;
  }

  bool isStudentInfoAvailable() {
    // var items = [
    //   studentName.value,
    //   studentGender.value,
    //   studentAddress.value,
    //   studentPhone.value,
    //   studentMail.value,
    // ];
    // bool isAvailable = true;
    // items.forEach((element) {
    //   if (element == null || element == '') {
    //     isAvailable = false;
    //   }
    //   if (studentBirthDay.value.isBefore(DateTime(2018))) {
    //     isAvailable = false;
    //   }
    //   if (isAvailable) return;
    // });
    // print('$isAvailable' + '______line153');
    // return isAvailable;
  }

  Future<void> onPressedStudentConfirm(BuildContext context) async {
    // if (isStudentInfoAvailable()) {
    //   var student = Student(
    //     name: studentName.value,
    //     gender: EnumConverter.stringToGender(studentGender.value),
    //     birthDay: studentBirthDay.value,
    //     address: studentAddress.value,
    //     phone: studentPhone.value,
    //     mail: studentMail.value,
    //   );
    //   bool result = await userService.addStudent(ajentUser.value.uid, student);
    //   if (result) {
    //     Navigator.of(context).pop();
    //   } else {
    //     _showMyDialog(
    //       context: context,
    //       title: Text('Message!'),
    //       children: [
    //         Text('This is the message demo'),
    //         Text('Line 1'),
    //         Text('Line 2'),
    //       ],
    //       actions: [
    //         TextButton(
    //           onPressed: () {},
    //           child: Text('OK'),
    //         ),
    //       ],
    //     );
    //   }
    // } else {
    //   _showMyDialog(
    //     context: context,
    //     title: Text('Warning!'),
    //     children: [
    //       Text('Some student input information have something wrong'),
    //       Text('Please check and try again.'),
    //     ],
    //     actions: [
    //       TextButton(
    //         onPressed: () {
    //           Navigator.of(context).pop();
    //         },
    //         child: Text('OK'),
    //       ),
    //     ],
    //   );
    // }
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
}
