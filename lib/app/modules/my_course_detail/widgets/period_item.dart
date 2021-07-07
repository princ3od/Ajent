import 'package:ajent/app/data/models/Period.dart';
import 'package:ajent/core/utils/date_converter.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
class PeriodItem extends StatelessWidget {
  final textStyle = GoogleFonts.nunitoSans(
      color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600);
  final int index;
  final Period period;
  PeriodItem({@required this.index, @required this.period});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      color: primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Period".tr+ " ${index + 1}", style: textStyle),
            Text(
                "${DateConverter.timeToString(period.lessonTime.startTime)} - ${DateConverter.timeToString(period.lessonTime.endTime)} : ${DateConverter.getTimeInDate(period.date.millisecondsSinceEpoch)}",
                style: textStyle),
          ],
        ),
      ),
    );
  }
}
