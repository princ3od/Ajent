import 'package:ajent/app/data/services/authenctic_service.dart';
import 'package:ajent/app/modules/auth/auth_controller.dart';
import 'package:ajent/app/modules/my_profile/my_profile_controller.dart';
import 'package:ajent/app/modules/my_profile/widgets/drop_down_widget_customize.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
          Text("email_label".tr,
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold, fontSize: 12)),
          TextField(
            decoration: primaryTextFieldDecoration,
            cursorColor: primaryColor,
            controller: controller.txtMail,
            enabled: (AuthController.loginType == LoginType.withGoogle),
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
            enabled: (AuthController.loginType == LoginType.byPhone),
          ),
          SizedBox(
            height: 20,
          ),
          Text('ajent_user_major_label'.tr,
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold, fontSize: 12)),
          TextField(
            decoration: primaryTextFieldDecoration,
            cursorColor: primaryColor,
            controller: controller.txtMajor,
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
              value: (controller.dropdownValue.value != '')
                  ? controller.dropdownValue.value
                  : null,
              onChanged: (newValue) {
                controller.dropdownValue.value = newValue;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await controller.updateInformation();
                },
                child: Obx(
                  () => (controller.isUpdatingInfo.value)
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text('profile_save_label'.tr,
                          style: GoogleFonts.nunitoSans(
                              fontSize: 14, fontWeight: FontWeight.w700)),
                ),
                style: orangeButtonStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
