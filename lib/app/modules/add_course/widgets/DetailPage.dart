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
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Số lượng học viên",
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
            "Giá tiền đề nghị (vnd)",
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
            "Địa điểm học",
            style: GoogleFonts.nunitoSans(),
          ),
          TextField(
            cursorColor: primaryColor,
            decoration: primaryTextFieldDecoration,
            controller: controller.txtCourseAddress,
          ),
        ],
      ),
    );
  }
}