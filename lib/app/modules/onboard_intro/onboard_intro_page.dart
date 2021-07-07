import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardIntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: IntroductionScreen(
      pages: [
        PageViewModel(
            title: 'Hire a tutor'.tr,
            body: 'Archive you goal'.tr,
            image: buildImage('assets/images/hire_a_tutor.png'),
            decoration: getPageDecoration()),
        PageViewModel(
            title: 'Become a tutor'.tr,
            body: 'Share the knowledge, get more income'.tr,
            image: buildImage('assets/images/be_a_tutor.png'),
            decoration: getPageDecoration()),
        PageViewModel(
            title: 'And more'.tr,
            body: 'Let discover Ajent!'.tr,
            image: buildImage('assets/images/and_more.png'),
            decoration: getPageDecoration()),
      ],
      done: Text(
        'Begin'.tr,
        style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
      ),
      onDone: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isFirst', false);
        Get.offAllNamed(Routes.HOME);
        HomeController.checkUserUpdateInfo();
      },
      showSkipButton: true,
      skip: Text('Skip'.tr),
      next: Text('Next'.tr),
      dotsDecorator: getDotDecoration(),
    ));
  }

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 360));
  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle:
            GoogleFonts.nunitoSans(fontWeight: FontWeight.bold, fontSize: 18),
        bodyTextStyle:
            GoogleFonts.nunitoSans(fontWeight: FontWeight.normal, fontSize: 14),
        imagePadding: EdgeInsets.all(24),
        pageColor: Colors.white,
      );
  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Color.fromARGB(205, 241, 116, 77),
        activeColor: primaryColor,
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );
}
