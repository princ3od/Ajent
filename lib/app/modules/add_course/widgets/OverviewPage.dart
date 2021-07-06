import 'dart:io';
import 'package:ajent/app/modules/add_course/add_course_controller.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textfield_tags/textfield_tags.dart';

class OverviewPage extends StatelessWidget {
  OverviewPage({Key key}) : super(key: key);
  final AddCourseController controller = Get.put(AddCourseController(Get.arguments));
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 110,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Obx(
                                () => (controller.imagePath.isEmpty)
                                ? Image(
                              image: AssetImage(
                                  'assets/images/no_img.png'),
                            )
                                : Image.file(
                              File(controller.imagePath.value),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.onChangeCouseImage();
                        },
                        child: Text("change_img".tr),
                        style: whiteButtonStyle,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "course's_name_label".tr,
                            style: GoogleFonts.nunitoSans(),
                          ),
                          TextField(
                            cursorColor: primaryColor,
                            decoration: primaryTextFieldDecoration,
                            controller: controller.txtCourseName,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "description_label".tr,
                            style: GoogleFonts.nunitoSans(),
                          ),
                          TextField(
                            cursorColor: primaryColor,
                            decoration: primaryTextFieldDecoration,
                            controller: controller.txtCourseDescription,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "subject_field_label".tr,
                style: GoogleFonts.nunitoSans(),
              ),
              SizedBox(
                height: 10,
              ),
              TextFieldTags(
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
                  controller.subjects.remove(tag);
                  print(controller.subjects);
                },
                onTag: (tag) {
                  controller.subjects.add(tag);
                },
                validator: (String tag) {
                  if (tag.length > 10) {
                    return "too_long_tag_warning".tr;
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
