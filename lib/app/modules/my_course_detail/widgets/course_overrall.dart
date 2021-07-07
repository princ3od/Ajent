import 'package:ajent/app/data/models/course.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:number_slide_animation/number_slide_animation.dart';

class CourseOverall extends StatelessWidget {
  final titleStyle = GoogleFonts.nunitoSans(fontSize: 12, color: Colors.grey);
  final contentStyle = GoogleFonts.nunitoSans(
      fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold);
  final Course course;
  CourseOverall({@required this.course});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Container(
        // height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.6), width: 0.8),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "time_label_on_add".tr,
                        style: titleStyle,
                      ),
                      Row(
                        children: [
                          NumberSlideAnimation(
                            duration: const Duration(milliseconds: 1200),
                            curve: Curves.fastOutSlowIn,
                            number: (course.getTotalHours() < 1000)
                                ? "${course.getTotalHours().toStringAsFixed(0)}"
                                : "999",
                            textStyle: contentStyle,
                          ),
                          if (course.getTotalHours() > 999)
                            Text(
                              '+',
                              style: contentStyle,
                            ),
                          Text(
                            'hh'.tr,
                            style: contentStyle,
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "number_of_student_label".tr,
                        style: titleStyle,
                      ),
                      Text(
                        "${course.maxLearner}" + " students".tr,
                        style: contentStyle,
                      ),
                    ],
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'tuition_label'.tr,
                        style: titleStyle,
                      ),
                      Text(
                        NumberFormat.currency(locale: "vi_VN", symbol: "vnd")
                            .format(course?.price ?? 0),
                        style: contentStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
