import 'package:ajent/app/global_widgets/user_avatar.dart';
import 'package:ajent/app/modules/auth/auth_controller.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/app/modules/home/widgets/language_button.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/cupertino.dart';
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
                    child: Hero(
                      tag: '${HomeController.mainUser.uid} avatar',
                      child: UserAvatar(
                        size: 45,
                        user: HomeController.mainUser,
                      ),
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
                            child: MaterialButton(
                              elevation: 2,
                              height: 5,
                              color: Color.fromARGB(255, 255, 255, 255),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              onPressed: () {
                                Get.toNamed(Routes.PROFILEVIEW,
                                    arguments: HomeController.mainUser);
                              },
                              child: Text(
                                "Personal infomation".tr,
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700, fontSize: 13),
                              ),
                              //style: outlinedButtonStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            LanguageButton(),
            SideMenuButton(
              text: "Request".tr,
              onPressed: () {
                Get.toNamed(Routes.REQUEST_VIEW);
              },
            ),
            SideMenuButton(
              text: "Edit profile page".tr,
              onPressed: () {
                Get.toNamed(Routes.PROFILE);
              },
            ),
            SideMenuButton(
              text: 'terms_title_label'.tr,
              onPressed: () {
                Get.toNamed(Routes.TERMS);
              },
            ),
            SideMenuButton(
              text: "About us".tr,
              onPressed: () {
                Get.toNamed(Routes.ABOUT);
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
                        child: MaterialButton(
                          onPressed: () {
                            AuthController.signOut();
                          },
                          child: Text(
                            "Logout".tr,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      )),
                  SizedBox(height: 5),
                  Text(
                    "© Ajent",
                    style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w500),
                  ),
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
