import 'dart:io';
import 'package:ajent/app/modules/add_course/add_course_controller.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textfield_tags/textfield_tags.dart';

class OverviewPage extends StatelessWidget {
  OverviewPage({Key key}) : super(key: key);
  final AddCourseController controller =
      Get.put(AddCourseController(Get.arguments));

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
                                    image:
                                        AssetImage('assets/images/no_img.png'),
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
                textfieldTagsController: controller.tagsController,
                validator: (String tag) {
                  if (tag.length > 10) {
                    return "too_long_tag_warning".tr;
                  }
                  return null;
                },
                textSeparators: const [','],
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
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
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
                                            color: Color.fromARGB(
                                                255, 233, 233, 233),
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
            ],
          ),
        ),
      ),
    );
  }
}
