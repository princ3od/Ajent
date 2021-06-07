import 'package:ajent/app/global_widgets/user_avatar.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
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
          style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: UserAvatar(
                  user: HomeController.mainUser,
                  size: 45,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Đổi ảnh"),
                  style: whiteButtonStyle,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Họ và tên",
                  style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
              TextField(
                decoration: primaryTextFieldDecoration,
                cursorColor: primaryColor,
                controller:
                    TextEditingController(text: HomeController.mainUser.name),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Text("Email"),
              TextField(
                decoration: primaryTextFieldDecoration,
                cursorColor: primaryColor,
                controller:
                    TextEditingController(text: HomeController.mainUser.mail),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Text("Số điện thoại"),
              TextField(
                decoration: primaryTextFieldDecoration,
                cursorColor: primaryColor,
                keyboardType: TextInputType.phone,
                controller:
                    TextEditingController(text: HomeController.mainUser.phone),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Bằng cấp, trình độ"),
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
                  child: Text("Lưu"),
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
