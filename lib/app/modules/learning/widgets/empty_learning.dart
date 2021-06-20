import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class EmptyLearning extends StatelessWidget {
  final int index;
  var imgPath = [
    'empty_finished_learning.png',
    'empty_ongoing_learning.png',
    'empty_upcoming_learning.png',
  ];
  var title = [
    'learning_finished empty'.tr,
    'learning_ongoing_empty'.tr,
    'learning_upcoming_empty'.tr,
  ];
  var content = [
    'learning_empty_encourage'.tr,
    'learning_empty_action'.tr,
    'learning_empty_action'.tr,
  ];
  EmptyLearning({Key key, @required this.index}) : super(key: key);

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
