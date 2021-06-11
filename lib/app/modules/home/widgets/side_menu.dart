import 'package:ajent/app/global_widgets/user_avatar.dart';
import 'package:ajent/app/modules/auth/auth_controller.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: UserAvatar(
                      size: 30,
                      user: HomeController.mainUser,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Text(
                          HomeController.mainUser.name,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 12.0, left: 4.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: OutlinedButton(
                              onPressed: () {
                                Get.toNamed(Routes.PROFILE);
                              },
                              child: Text("Thông tin cá nhân", style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w700,fontSize: 11),),
                              style: outlinedButtonStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SideMenuButton(
              text: "Lịch sử",
              onPressed: () {},
            ),
            SideMenuButton(
              text: "Cài đặt",
              onPressed: () {},
            ),
            SideMenuButton(
              text: "Quy định & chính sách",
              onPressed: () {},
            ),
            SideMenuButton(
              text: "Giới thiệu",
              onPressed: () {
                showAboutDialog(
                  context: context,
                  applicationVersion: '1.0.0',
                  applicationIcon: Container(
                    child: Image.asset("assets/images/ajent_logo.png"),
                    width: 50,
                    height: 50,
                  ),
                  applicationLegalese: 'Copyright 2021 Ajent',
                  children: [
                    SizedBox(height: 10),
                    Text("Tutor searching app"),
                  ],
                );
              },
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 5),
                        child: OutlinedButton(
                            onPressed: () {
                              AuthController.signOut();
                            },
                            child: Text(
                              "Đăng xuất",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600),
                            ),
                            style: OutlinedButton.styleFrom(
                              primary: Colors.red,
                              onSurface: primaryColor,
                              padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                              side: BorderSide(color: Colors.red, width: 1.6),
                            )),
                      )),
                  SizedBox(height: 5),
                  Text("© Ajent"),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SideMenuButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const SideMenuButton({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 50,
        child: TextButton(onPressed: this.onPressed, child: Text(this.text)));
  }
}
