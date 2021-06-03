import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          "Tùy chỉnh thông tin cá nhân",
          style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/demo.png"),
                  radius: 40.0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Đổi ảnh", style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),),
                  style: whiteButtonStyle,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Họ và tên", style: GoogleFonts.nunitoSans(),),
              TextField(
                decoration: primaryTextFieldDecoration,
                cursorColor: primaryColor,
              ),
              SizedBox(
                height: 20,
              ),
              Text("Email", style: GoogleFonts.nunitoSans(),),
              TextField(
                decoration: primaryTextFieldDecoration,
                cursorColor: primaryColor,
              ),
              SizedBox(
                height: 20,
              ),
              Text("Số điện thoại", style: GoogleFonts.nunitoSans(),),
              TextField(
                decoration: primaryTextFieldDecoration,
                cursorColor: primaryColor,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(
                height: 20,
              ),
              Text("Bằng cấp, trình độ", style: GoogleFonts.nunitoSans(),),
              TextField(
                decoration: primaryTextFieldDecoration,
                cursorColor: primaryColor,
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Lưu", style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),),
                  style: orangeButtonStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}