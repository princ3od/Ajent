import 'package:ajent/app/modules/add_course/add_course_controller.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatelessWidget {
  DetailPage({Key key}) : super(key: key);

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
              Text(
                "number_of_student_label".tr,
                style: GoogleFonts.nunitoSans(),
              ),
              TextField(
                cursorColor: primaryColor,
                decoration: primaryTextFieldDecoration,
                controller: controller.txtStudentNum,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "tuition_label".tr,
                style: GoogleFonts.nunitoSans(),
              ),
              TextField(
                cursorColor: primaryColor,
                decoration: primaryTextFieldDecoration,
                controller: controller.txtCoursePrice,
                onChanged: controller.formatCurrencyText,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "location_label".tr,
                style: GoogleFonts.nunitoSans(),
              ),
              TextField(
                cursorColor: primaryColor,
                decoration: primaryTextFieldDecoration,
                controller: controller.txtCourseAddress,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
