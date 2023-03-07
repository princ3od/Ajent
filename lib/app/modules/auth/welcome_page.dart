import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          "Tutor Time",
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
                flex: 2,
                child: Column(
                  children: [
                    Expanded(
                      child: Hero(
                        tag: "bottom bar",
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(200),
                              topRight: Radius.circular(200),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Image.asset(
                                    "assets/images/welcome_page_img.png"),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Get.toNamed(Routes.AUTH);
                                            },
                                            child: Text('login'.tr),
                                            style: primaryButtonSytle,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          child: OutlinedButton(
                                            onPressed: () {
                                              Get.toNamed(Routes.SIGNUP);
                                            },
                                            child: Text('sign_up'.tr),
                                            style: outlinedButtonStyle,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
