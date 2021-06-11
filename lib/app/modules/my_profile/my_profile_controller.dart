import 'dart:io';
import 'package:ajent/app/data/models/Degree.dart';
import 'package:ajent/app/data/models/Student.dart';
import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/services/storage_service.dart';
import 'package:ajent/app/data/services/user_service.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfileController extends GetxController {
  Rx<String> name = HomeController.mainUser.name.obs;
  Rx<String> email = HomeController.mainUser.mail.obs;
  Rx<String> school = HomeController.mainUser.schoolName.obs;
  Rx<String> phone = HomeController.mainUser.phone.obs;
  Rx<String> major = HomeController.mainUser.major.obs;
  Rx<String> educationLevel = HomeController.mainUser.educationLevel.obs;
  Rx<String> bio = HomeController.mainUser.bio.obs;
  RxList<Degree> degrees = HomeController.mainUser.degrees.obs;
  RxString dropdownValue = HomeController.mainUser.educationLevel.obs;
  RxList<Student> students = HomeController.mainUser.students.obs;

  Rx<AjentUser> ajentUser = HomeController.mainUser.obs;
  UserService userService = UserService.instance;
  StorageService storageService = StorageService.instance;
  // Rx<AjentUser> ajentUser = globalAjentUser.obs;

  Degree overDegee = Degree(imageUrl: '', title: '', description: '');
  Rx<File> image = File('').obs;
  RxString title = ''.obs;
  RxString description = ''.obs;

  List<DropdownMenuItem<String>> dropDownMenuItems = <String>[
    'ajent_education_level_drop_down_item1'.tr,
    'ajent_education_level_drop_down_item2'.tr,
    'ajent_education_level_drop_down_item3'.tr,
    'ajent_education_level_drop_down_item4'.tr,
    'ajent_education_level_drop_down_item5'.tr,
    'ajent_education_level_drop_down_item6'.tr,
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();

  Future<void> onClosedDiplomaOverlay(BuildContext context) async {
    image.value = File('');
    degrees.value =
        await this.userService.getDegrees(HomeController.mainUser.uid);
    Navigator.of(context).pop();
  }

  Future<void> updateInformation() async {
    AjentUser ajentUser = HomeController.mainUser;
    ajentUser.name = name.value;
    ajentUser.mail = email.value;
    ajentUser.schoolName = school.value;
    ajentUser.phone = phone.value;
    ajentUser.major = major.value;
    ajentUser.educationLevel = dropdownValue.value;
    ajentUser.bio = bio.value;
    await this.userService.updateInfo(ajentUser);
  }

  bool isAvailableInputInfo() {
    List<String> items = [
      name.value,
      email.value,
      bio.value,
      school.value,
      educationLevel.value,
      major.value,
      phone.value,
      dropdownValue.value,
    ];
    for (int i = 0; i < items.length; i++) {
      if (items[i] == null || items[i] == '') {
        return false;
      }
    }
    return true;
  }

  bool isAvaiableDegreeInfo() {
    List<String> items = [
      image.value.path,
      description.value,
      title.value,
    ];

    for (int i = 0; i < items.length; i++) {
      if (items[i] == null || items[i] == '') {
        return false;
      }
    }
    return true;
  }
}
