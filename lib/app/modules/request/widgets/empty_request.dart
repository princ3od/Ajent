import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class EmptyRequest extends StatelessWidget {
  final int index;
  var imgPath = [
    'their_request.png',
    'your_request.png',
  ];
  var title = [
    'You have no in-coming request'.tr,
    'You have not requested any course'.tr,
  ];
  EmptyRequest({Key key, @required this.index}) : super(key: key);

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
        SizedBox(height: kBottomNavigationBarHeight),
      ],
    );
  }
}
