import 'package:ajent/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyCourseDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Course Detail",
          style: GoogleFonts.nunitoSans(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.grey[100],
        toolbarHeight: 70,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Row(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/ajent_logo.png"),
                        radius: 40.0,
                      ),
                    ),
                    Text(
                      "My Course Name",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w700, fontSize: 14),
                    )
                  ])),
              Center(
                  child: OutlinedButton(
                    style: outlinedButtonStyle,
                    onPressed: () {
                      Get.toNamed(Routes.RATING);
                      },
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: Text(
                          "Đánh giá",
                          style: GoogleFonts.nunitoSans(
                              fontSize: 12, fontWeight: FontWeight.w700),
                        )
                    ),
                  )
              ),
              Text("Mã khóa",
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.bold, fontSize: 12)),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: TextFormField(
                  initialValue: "AJ01033",
                  decoration: primaryTextFieldDecoration,
                  cursorColor: primaryColor,
                  readOnly: true,
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
              Text("Họ và tên giảng viên",
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.bold, fontSize: 12)),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: TextFormField(
                  initialValue:
                      "Ajent Agency", //Get a link here to get to teacher profile page
                  decoration: primaryTextFieldDecoration,
                  cursorColor: primaryColor,
                  readOnly: true,
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
              Text("Số điện thoại giảng viên",
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.bold, fontSize: 12)),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: TextFormField(
                  initialValue: "093812345",
                  decoration: primaryTextFieldDecoration,
                  cursorColor: primaryColor,
                  keyboardType: TextInputType.phone,
                  readOnly: true,
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
              Text("Địa điểm học",
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.bold, fontSize: 12)),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: TextFormField(
                  initialValue:
                      " Lầu 2 phòng 2.14 Glacial Enterprise 69 Nguyễn Huệ, Phường Bến Nghé, Quận 1, TP.HCM ", //Get a link here to get to google maps.
                  decoration: primaryTextFieldDecoration,
                  cursorColor: primaryColor,
                  readOnly: true,
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
              Text("Hình thức học",
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.bold, fontSize: 12)),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: TextFormField(
                  initialValue: "Học nhóm",
                  decoration: primaryTextFieldDecoration,
                  cursorColor: primaryColor,
                  readOnly: true,
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
              Text("Thời gian học",
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.bold, fontSize: 12)),
              TextFormField(
                initialValue:
                    "T2 - T4 - T6 : 19h00 -21h00, bắt đầu từ 12/6/2021",
                decoration: primaryTextFieldDecoration,
                cursorColor: primaryColor,
                readOnly: true,
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w600, fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text("© Ajent ",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w100, fontSize: 12))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
