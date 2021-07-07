import 'package:ajent/app/data/models/fixed_time.dart';
import 'package:ajent/core/utils/date_converter.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class FixedTimeCard extends StatelessWidget {
  final FixedTime fixedTime;
  FixedTimeCard({@required this.fixedTime});
  @override
  Widget build(BuildContext context) {
    List<String> weekDays = DateConverter.weekDays();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("time_label_on_add".tr,
                            style: GoogleFonts.nunitoSans(
                                color: Colors.white, fontSize: 10)),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'From'.tr,
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.white, fontSize: 14)),
                            TextSpan(
                                text:
                                    ' ${DateConverter.getTimeInDate(fixedTime.startDate.millisecondsSinceEpoch)} ',
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: 'to'.tr,
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.white, fontSize: 14)),
                            TextSpan(
                                text:
                                    ' ${DateConverter.getTimeInDate(fixedTime.endDate.millisecondsSinceEpoch)}',
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                          ]),
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'Study time:'.tr,
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.white, fontSize: 14)),
                            TextSpan(
                                text:
                                    ' ${DateConverter.timeToString(fixedTime.lessonTime.startTime)} - ${DateConverter.timeToString(fixedTime.lessonTime.endTime)}',
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                          ]),
                        ),
                      ],
                    ),
                  ),
                )),
            Expanded(
                flex: 4,
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Study day in a week".tr,
                            style: GoogleFonts.nunitoSans(
                                color: Colors.black, fontSize: 10)),
                        SizedBox(height: 4),
                        Flexible(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: weekDays.length,
                            itemBuilder: (context, index) {
                              return WeekDayItem(
                                  text: weekDays[index],
                                  isSelected: fixedTime.day[index]);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class WeekDayItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  WeekDayItem({Key key, @required this.text, @required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Container(
        width: 40,
        decoration: BoxDecoration(
          color: primaryColor.withOpacity((isSelected) ? 1 : 0.1),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: Text(text,
                style: GoogleFonts.nunitoSans(
                    color: (isSelected) ? Colors.white : Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
