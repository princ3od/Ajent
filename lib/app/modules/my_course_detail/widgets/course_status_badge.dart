import 'package:ajent/app/data/models/course.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
class CourseStatusBadge extends StatelessWidget {
  final CourseStatus status;
  CourseStatusBadge({Key key, @required this.status}) : super(key: key);
  final Map<CourseStatus, String> texts = {
    CourseStatus.fininished: 'Ended'.tr,
    CourseStatus.ongoing: 'Ongoing'.tr,
    CourseStatus.upcoming: 'Upcoming'.tr,
  };
  final Map<CourseStatus, Color> colors = {
    CourseStatus.fininished: Colors.red,
    CourseStatus.ongoing: Colors.green,
    CourseStatus.upcoming: Colors.amber.shade700,
  };
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: colors[status],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: Text(texts[status],
                    maxLines: 1,
                    style: GoogleFonts.nunitoSans(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
