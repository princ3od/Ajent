import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class EmptyTeaching extends StatelessWidget {
  final int index;
  var imgPath = [
    'empty_finished_teaching.png',
    'empty_ongoing_teaching.png',
    'empty_upcoming_teaching.png',
  ];
  var title = [
    'teaching_finished empty'.tr,
    'teaching_ongoing_empty'.tr,
    'teaching_upcoming_empty'.tr,
  ];
  var content = [
    'teaching_empty_encourage'.tr,
    'teaching_empty_action'.tr,
    'teaching_empty_action'.tr,
  ];
  EmptyTeaching({Key key, @required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: Get.width - 20,
                maxHeight: Get.width -
                    kBottomNavigationBarHeight -
                    kFloatingActionButtonMargin * 2),
            child: Image.asset("assets/images/${imgPath[index]}")),
        Text(
          title[index],
          style: GoogleFonts.nunitoSans(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          content[index],
          style: GoogleFonts.nunitoSans(
            fontSize: 12,
          ),
        ),
        SizedBox(height: kBottomNavigationBarHeight),
      ],
    );
  }
}
