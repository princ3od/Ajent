import 'dart:io';
import 'package:ajent/app/data/models/Degree.dart';
import 'package:ajent/app/data/models/Student.dart';
import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/services/storage_service.dart';
import 'package:ajent/app/data/services/user_service.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/app/modules/my_profile/widgets/student_detail.dart';
import 'package:ajent/core/utils/enum_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

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
      child: Text(
        value,
        style: GoogleFonts.nunitoSans(fontSize: 13),
      ),
    );
  }).toList();
  //Using to changing avatar of main user
  Rx<File> avatar = File('').obs;
  Future<void> onClickChangeAvatar(
      {@required MyProfileController controller}) async {
    final picker = ImagePicker();
    await getImage(picker, controller);
    if (controller.avatar.value.path != '') {
      await this.userService.updateUserAvatar(ajentUser.value, avatar.value);

      ajentUser.value = AjentUser.cloneWith(ajentUser.value);
      avatar = File('').obs;
      print('This is the link of avatar ${this.ajentUser.value.avatarUrl}');
    }
  }

  Future getImage(ImagePicker picker, MyProfileController controller) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      controller.avatar.value = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

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

  //Using to and student
  RxString studentName = ''.obs;
  RxString studentGender = 'male'.obs;
  Rx<DateTime> studentBirthDay = DateTime.now().obs;
  RxString studentAddress = ''.obs;
  RxString studentPhone = ''.obs;
  RxString studentMail = ''.obs;
  bool isStudentInfoAvailable() {
    var items = [
      studentName.value,
      studentGender.value,
      studentAddress.value,
      studentPhone.value,
      studentMail.value,
    ];
    bool isAvailable = true;
    items.forEach((element) {
      if (element == null || element == '') {
        isAvailable = false;
      }
      if (studentBirthDay.value.isBefore(DateTime(2018))) {
        isAvailable = false;
      }
      if (isAvailable) return;
    });
    print('$isAvailable' + '______line153');
    return isAvailable;
  }

  Future<void> onPressedStudentConfirm(BuildContext context) async {
    if (isStudentInfoAvailable()) {
      var student = Student(
        name: studentName.value,
        gender: EnumConverter.stringToGender(studentGender.value),
        birthDay: studentBirthDay.value,
        address: studentAddress.value,
        phone: studentPhone.value,
        mail: studentMail.value,
      );
      bool result = await userService.addStudent(ajentUser.value.uid, student);
      if (result) {
        Navigator.of(context).pop();
      } else {
        _showMyDialog(
          context: context,
          title: Text('Message!'),
          children: [
            Text('This is the message demo'),
            Text('Line 1'),
            Text('Line 2'),
          ],
          actions: [
            TextButton(
              onPressed: () {},
              child: Text('OK'),
            ),
          ],
        );
      }
    } else {
      _showMyDialog(
        context: context,
        title: Text('Warning!'),
        children: [
          Text('Some student input information have something wrong'),
          Text('Please check and try again.'),
        ],
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    }
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
}
