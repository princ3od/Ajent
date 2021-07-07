import 'dart:math';

import 'package:ajent/app/data/models/Person.dart';
import 'package:ajent/app/data/services/authenctic_service.dart';
import 'package:ajent/app/modules/add_course/widgets/DatePickingButton.dart';
import 'package:ajent/app/modules/auth/auth_controller.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/app/modules/my_profile/my_profile_controller.dart';
import 'package:ajent/app/modules/my_profile/widgets/drop_down_widget_customize.dart';
import 'package:ajent/app/modules/my_profile/widgets/gender_radio.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:textfield_tags/textfield_tags.dart';

class InformationTab extends StatelessWidget {
  final MyProfileController controller = Get.find();

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

  var educationLevel = {
    'ajent_education_level_drop_down_item1'.tr: 'Student',
    'ajent_education_level_drop_down_item2'.tr: 'Undergraduate',
    'ajent_education_level_drop_down_item3'.tr: 'Bachelor',
    'ajent_education_level_drop_down_item4'.tr: 'Master',
    'ajent_education_level_drop_down_item5'.tr: 'PhD',
    'ajent_education_level_drop_down_item6'.tr: 'Professor',
  };
  var educationLevelReversal = {
    'Student': 'ajent_education_level_drop_down_item1'.tr,
    'Undergraduate': 'ajent_education_level_drop_down_item2'.tr,
    'Bachelor': 'ajent_education_level_drop_down_item3'.tr,
    'Master': 'ajent_education_level_drop_down_item4'.tr,
    'PhD': 'ajent_education_level_drop_down_item5'.tr,
    'Professor': 'ajent_education_level_drop_down_item6'.tr,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ajent_user_name_label'.tr,
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold, fontSize: 12)),
          TextField(
            decoration: primaryTextFieldDecoration,
            cursorColor: primaryColor,
            controller: controller.txtName,
          ),
          SizedBox(
            height: 20,
          ),
          Text('Date of birth'.tr,
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold, fontSize: 12)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Obx(
              () => DatePickingButton(
                date: controller.startDate.value,
                onPressed: () async {
                  controller.startDate.value = await showDatePicker(
                      context: context,
                      initialDate: controller.startDate.value ?? DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 30),
                      lastDate: DateTime(DateTime.now().year + 1));
                  if (controller.startDate.value != null)
                    controller.ajentUser.value.birthDay =
                        controller.startDate.value;
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text('Gender'.tr,
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold, fontSize: 12)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GenderRadio(
              initGender: controller.ajentUser.value.gender ?? Gender.female,
              onChanged: (value) {
                controller.ajentUser.value.gender = value;
              },
            ),
          ),
          Text("email_label".tr,
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold, fontSize: 12)),
          TextField(
            decoration: primaryTextFieldDecoration,
            cursorColor: primaryColor,
            controller: controller.txtMail,
            enabled: (AuthController.loginType != LoginType.withGoogle),
          ),
          SizedBox(
            height: 20,
          ),
          Text('school_name_label'.tr,
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold, fontSize: 12)),
          TextField(
            decoration: primaryTextFieldDecoration,
            cursorColor: primaryColor,
            controller: controller.txtSchool,
          ),
          SizedBox(
            height: 20,
          ),
          Text('phone_number_label'.tr,
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold, fontSize: 12)),
          TextField(
            decoration: primaryTextFieldDecoration,
            cursorColor: primaryColor,
            keyboardType: TextInputType.phone,
            controller: controller.txtPhone,
            enabled: (AuthController.loginType != LoginType.byPhone),
          ),
          SizedBox(
            height: 20,
          ),
          Text('ajent_user_major_label'.tr,
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold, fontSize: 12)),
          TextFieldTags(
            initialTags: controller.createTags().length > 0
                ? controller.createTags()
                : ["Tags"],
            tagsStyler: TagsStyler(
              showHashtag: true,
              tagMargin: const EdgeInsets.only(right: 4.0),
              tagCancelIcon:
                  Icon(Icons.cancel, size: 15.0, color: Colors.white),
              tagCancelIconPadding: EdgeInsets.only(left: 4.0, top: 2.0),
              tagPadding:
                  EdgeInsets.only(top: 2.0, bottom: 4.0, left: 8.0, right: 4.0),
              tagDecoration: BoxDecoration(
                color: primaryColor,
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              tagTextStyle:
                  TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
            ),
            textFieldStyler: TextFieldStyler(
              helperText: null,
              hintText: "Tags",
              textStyle: GoogleFonts.nunitoSans(),
              isDense: false,
              textFieldBorder: null,
              textFieldFocusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor, width: 1.0),
              ),
            ),
            onDelete: (tag) {
              print(tag);
              List<String> items = HomeController.mainUser.major.split(" ");
              items.remove(tag);
              String result = "";
              items.forEach((item) {
                result += " $item";
              });
              HomeController.mainUser.major = result;
            },
            onTag: (tag) {
              if (HomeController.mainUser.major == null)
                HomeController.mainUser.major = "";
              HomeController.mainUser.major += " $tag";
              print(HomeController.mainUser.major);
            },
            validator: (String tag) {
              if (tag.length > 10) {
                return 'too_long_tag_warning'.tr;
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'ajent_user_education_level_label'.tr,
            style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.bold, fontSize: 12),
          ),
          SizedBox(
            height: 10,
          ),
          Obx(
            () => MyDropDownWidget(
              items: dropDownMenuItems,
              value: (controller.dropdownValue.value.isNotEmpty)
                  ? educationLevelReversal[controller.dropdownValue.value]
                  : null,
              onChanged: (newValue) {
                controller.dropdownValue.value = educationLevel[newValue];
                print('${controller.dropdownValue.value}');
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text('ajent_bio_label'.tr,
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold, fontSize: 12)),
          TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: primaryTextFieldDecoration,
            cursorColor: primaryColor,
            controller: controller.txtBio,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
