
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyTeachingDetailPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Teaching's name",
          //course.name,
          overflow: TextOverflow.fade,
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
      body: Center(
          child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
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
                                backgroundImage: AssetImage(
                                    "assets/images/ajent_logo.png"),
                                radius: 40.0,
                              ),
                            ),
                            Text(
                              "Teaching's name",
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w700, fontSize: 14),
                            )
                          ])),
                      Text("Mã khóa",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                        child: TextFormField(
                          initialValue: '1929391',
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
                          onTap: () {
                            print('teacher details');
                          },
                          initialValue: 'Trần Văn A'
                          , //Get a link here to get to teacher profile page
                          decoration: primaryTextFieldDecoration,
                          cursorColor: primaryColor,
                          readOnly: true,
                          style: GoogleFonts.nunitoSans(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        ),
                      ),
                      Text("Địa điểm dạy",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                        child: TextFormField(

                          initialValue: "Quận 1", //Get a link here to get to google maps.
                          decoration: primaryTextFieldDecoration,
                          cursorColor: primaryColor,
                          readOnly: true,
                          style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text("Thời gian học",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                      TextFormField(
                        initialValue: 'T2 - T7 - CN : 14h00 - 19h00',
                        decoration: primaryTextFieldDecoration,
                        cursorColor: primaryColor,
                        readOnly: true,
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                      SizedBox(height: 8),
                      Text("Chi phí khóa",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                      TextFormField(
                        initialValue: '10 000 000 đ',
                        decoration: primaryTextFieldDecoration,
                        cursorColor: primaryColor,
                        readOnly: true,
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                      SizedBox(height: 8),
                      Text("Hình thức dạy",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                      TextFormField(
                        initialValue: 'Dạy nhóm',
                        decoration: primaryTextFieldDecoration,
                        cursorColor: primaryColor,
                        readOnly: true,
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),

                      SizedBox(height: 8),
                      Text("Ngày bắt đầu - ngày kết thúc ",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                      TextFormField(
                        initialValue: '12/12/2021 - 4/6/2022',
                        decoration: primaryTextFieldDecoration,
                        cursorColor: primaryColor,
                        readOnly: true,
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                      SizedBox(height: 8),
                      Text("Thông tin học viên",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                      TextFormField(
                        initialValue: 'Trần Văn B, Nguyễn Văn C, Nguyễn Văn D',
                        decoration: primaryTextFieldDecoration,
                        cursorColor: primaryColor,
                        readOnly: true,
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                      SizedBox(height: 8),
                      Text("Số lượng học viên",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                      TextFormField(
                        initialValue: '3',
                        decoration: primaryTextFieldDecoration,
                        cursorColor: primaryColor,
                        readOnly: true,
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Center(
                              child: Text("© Ajent ",
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w100, fontSize: 12))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),

    ));
  }
}
