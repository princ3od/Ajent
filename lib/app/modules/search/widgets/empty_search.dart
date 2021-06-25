import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptySearch extends StatelessWidget {
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
                  maxWidth: Get.width,
                  maxHeight: Get.width - kBottomNavigationBarHeight),
              child: Image.asset("assets/images/search_empty.png")),
          Text(
            "Let's find some new courses! 😉",
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
