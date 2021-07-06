import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NoResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: Get.width - 40,
                  maxHeight: Get.width - kBottomNavigationBarHeight - 40),
              child: Image.asset("assets/images/empty_result.png")),
          Text(
            "Oops, no result for you. 🧐".tr,
            style: GoogleFonts.nunitoSans(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: kBottomNavigationBarHeight * 2,
          ),
        ],
      ),
    );
  }
}
