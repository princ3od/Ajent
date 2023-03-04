import 'package:ajent/app/data/models/Person.dart';
import 'package:ajent/app/data/services/authenctic_service.dart';
import 'package:ajent/app/modules/add_course/widgets/DatePickingButton.dart';
import 'package:ajent/app/modules/auth/auth_controller.dart';
import 'package:ajent/app/modules/my_profile/my_profile_controller.dart';
import 'package:ajent/app/modules/my_profile/widgets/drop_down_widget_customize.dart';
import 'package:ajent/app/modules/my_profile/widgets/gender_radio.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
            initialTags: controller.ajentUser.value.major.split(','),
            validator: (String tag) {
              if (tag.length > 10) {
                return "too_long_tag_warning".tr;
              }
              return null;
            },
            textSeparators: [','],
            textfieldTagsController: controller.tagsController,
            inputfieldBuilder: (context, txtController, focusNode, error,
                onChanged, onSubmitted) {
              return ((context, scrollController, tags, onTagDelete) {
                return TextField(
                  controller: txtController,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    helperText: "Tags should be separated by commas".tr,
                    hintText: tags.isEmpty ? "Tags".tr : "",
                    errorText: error,
                    prefixIcon: tags.isNotEmpty
                        ? SingleChildScrollView(
                            controller: scrollController,
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: tags.map((String tag) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                  color: primaryColor,
                                ),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      child: Text(
                                        '#$tag',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      onTap: () {
                                        print("$tag selected");
                                      },
                                    ),
                                    const SizedBox(width: 4.0),
                                    InkWell(
                                      child: const Icon(
                                        Icons.cancel,
                                        size: 14.0,
                                        color:
                                            Color.fromARGB(255, 233, 233, 233),
                                      ),
                                      onTap: () {
                                        onTagDelete(tag);
                                      },
                                    )
                                  ],
                                ),
                              );
                            }).toList()),
                          )
                        : null,
                  ),
                  onChanged: onChanged,
                  onSubmitted: onSubmitted,
                );
              });
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
