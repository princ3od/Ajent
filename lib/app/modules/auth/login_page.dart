import 'package:ajent/app/modules/auth/auth_controller.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  final AuthController controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            size: 30,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Hero(
                tag: "logo",
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.asset("assets/images/ajent_logo.png"),
                      width: 100,
                      height: 100,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        "Ajent",
                        style: GoogleFonts.suezOne(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        "Move forward",
                        style: GoogleFonts.nunitoSans(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Obx(() => controller.isSigningIn.value
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'logining_text'.tr,
                          style: GoogleFonts.nunitoSans(),
                        ),
                      ],
                    )
                  : buildSignIn()),
            ),
            Hero(
              child: Container(
                height: 0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(400),
                    topRight: Radius.circular(400),
                  ),
                ),
              ),
              tag: "bottom bar",
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSignIn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ButtonWithLeadIcon(
              onPressed: () => controller.loginWithGoogle(),
              text: 'login_google'.tr,
              path: "assets/images/google_logo.png",
            ),
          ),
        ),
        SizedBox(height: 2),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ButtonWithLeadIcon(
              onPressed: () => controller.loginWithFacebook(),
              text: 'login_facebook'.tr,
              path: "assets/images/fb_logo.png",
            ),
          ),
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
              ),
            ),
            Text(
              'or'.tr,
              style: GoogleFonts.nunitoSans(color: Colors.white),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ButtonWithLeadIcon(
              onPressed: () => Get.toNamed(Routes.SIGNUP),
              text: 'login_phone'.tr,
              path: "assets/images/phone.png",
            ),
          ),
        ),
        SizedBox(height: 25)
      ],
    );
  }
}

class ButtonWithLeadIcon extends StatelessWidget {
  final String text;
  final String path;
  final Function onPressed;
  const ButtonWithLeadIcon({
    Key key,
    @required this.text,
    @required this.path,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                  child: Image.asset(
                path,
                width: 25,
                height: 25,
              )),
            ),
            Expanded(
              flex: 5,
              child: Text(text,
                  style: GoogleFonts.nunitoSans(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: primaryColor,
          padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
        ));
  }
}
