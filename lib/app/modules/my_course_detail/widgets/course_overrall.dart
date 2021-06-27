import 'package:ajent/app/data/models/course.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CourseOverall extends StatelessWidget {
  final titleStyle = GoogleFonts.nunitoSans(fontSize: 12, color: Colors.grey);
  final contentStyle = GoogleFonts.nunitoSans(
      fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold);
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
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Thời gian",
                        style: titleStyle,
                      ),
                      Text(
                        "12 giờ",
                        style: contentStyle,
                      ),
                    ],
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Số lượng dự kiến",
                        style: titleStyle,
                      ),
                      Text(
                        "${course.maxLearner} người",
                        style: contentStyle,
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
                        "Giá tiền đề nghị",
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
