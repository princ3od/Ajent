import 'package:ajent/app/modules/add_course/add_course_controller.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCoursePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int pageindex = ModalRoute.of(context).settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.grey[100],
        toolbarHeight: 70.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Mở lớp',
          style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
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
                        child: Image(image: AssetImage('assets/images/no_img.png'),),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){},
                      child: Text("Đổi ảnh"),
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
                        Text("Tên khóa học", style: GoogleFonts.nunitoSans(),),
                        TextField(
                          cursorColor: primaryColor,
                          decoration: primaryTextFieldDecoration,
                        ),
                        SizedBox(height: 10,),
                        Text("Mã khóa", style: GoogleFonts.nunitoSans(),),
                        TextField(
                          cursorColor: primaryColor,
                          decoration: primaryTextFieldDecoration,
                        ),
                      ],
                    ),
                  ),
                )

              ],
            ),
            SizedBox(height: 10,),
            Text("Đề tài khóa học", style: GoogleFonts.nunitoSans(),),
          ],
        ),
      ),
    );
  }
}
