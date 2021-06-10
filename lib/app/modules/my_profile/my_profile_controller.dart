import 'dart:io';

import 'package:ajent/app/data/models/Degree.dart';
import 'package:ajent/app/data/models/Person.dart';
import 'package:ajent/app/data/models/Student.dart';
import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/modules/my_profile/widgets/overlay_diploma.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfileController extends GetxController {
  // Rx<AjentUser> ajentUser = HomeController.mainUser.obs;
  Rx<AjentUser> ajentUser = globalAjentUser.obs;
  RxString dropdownValue = ''.obs;
  Degree overDegee = Degree(imageUrl: '', title: '', description: '');
  Rx<File> image;
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
  OverlayEntry overlayEntry;

  void showOverlay(BuildContext context) async {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => DiplomaLayout(
          onClickConfirm: () {}, onClickCancel: () {}, onDelete: closeOverlay),
    );
    overlayState.insert(overlayEntry);
    await Future.delayed(Duration(seconds: 3));
    this.overlayEntry = overlayEntry;
  }

  void closeOverlay() {
    if (overlayEntry != null) {
      overlayEntry.remove();
    }
  }
}

// Fake date using to testing
AjentUser globalAjentUser = AjentUser(
  'uid',
  'Name',
  DateTime.now(),
  Gender.female,
  'address',
  'phone',
  'mail',
  'avatarUrl',
  'schoolName',
  'major',
  'educationLevel',
  'bio',
)
  ..degrees = <Degree>[
    Degree(
        imageUrl:
            'https://thapgiainhietliangchi.com/wp-content/uploads/2021/03/diploma-la-gi-7.jpg',
        title: 'CN CNTT',
        description:
            'Tot nghiep loai gioi chuyen nghanh cong nghe thong tin DHQG TPHCM'),
    Degree(
        imageUrl:
            'https://image.freepik.com/free-vector/modern-diploma-template_52683-40720.jpg',
        title: 'Master CNTT',
        description:
            'Tot nghiep loai gioi chuyen nghanh cong nghe moi truong DHQG TPHCM'),
    Degree(
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/A1-TWbDp0WL._AC_SL1500_.jpg',
        title: 'Phd CNTT',
        description:
            'Tot nghiep loai gioi chuyen nghanh cong nghe moi truong DHQG TPHCM'),
    Degree(
        imageUrl:
            'https://thapgiainhietliangchi.com/wp-content/uploads/2021/03/diploma-la-gi-7.jpg',
        title: 'CN CNTT',
        description:
            'Tot nghiep loai gioi chuyen nghanh cong nghe thong tin DHQG TPHCM'),
    Degree(
        imageUrl:
            'https://image.freepik.com/free-vector/modern-diploma-template_52683-40720.jpg',
        title: 'Master CNTT',
        description:
            'Tot nghiep loai gioi chuyen nghanh cong nghe moi truong DHQG TPHCM'),
    Degree(
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/A1-TWbDp0WL._AC_SL1500_.jpg',
        title: 'Phd CNTT',
        description:
            'Tot nghiep loai gioi chuyen nghanh cong nghe moi truong DHQG TPHCM'),
  ]
  ..students = <Student>[
    Student('id01', 'Name01', DateTime.now(), Gender.male, 'address01',
        'phone01', 'mail01'),
    Student('id02', 'Name01', DateTime.now(), Gender.female, 'address02',
        'phone01', 'mail02'),
    Student('id03', 'Name03', DateTime.now(), Gender.male, 'address03',
        'phone03', 'mail03'),
    Student('id01', 'Name01', DateTime.now(), Gender.male, 'address01',
        'phone01', 'mail01'),
    Student('id02', 'Name01', DateTime.now(), Gender.female, 'address02',
        'phone01', 'mail02'),
    Student('id03', 'Name03', DateTime.now(), Gender.male, 'address03',
        'phone03', 'mail03'),
  ];
