import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class TeachingCalendarEventCard extends StatelessWidget {
  final Course course;

  const TeachingCalendarEventCard({Key key, @required this.course})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
          elevation: 0,
          color: Color.fromARGB(255, 97, 159, 205),
          child: Container(
              child: Row(
            children: [
              SizedBox(
                width: 10,
                height: 123,
                child: Container(
                  color: Colors.black,
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "teach".tr,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                  color: primaryColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text("${course.timeInCalendar.toString()}",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 255, 255, 255))),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text("${course.name}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w900,
                                    color: Color.fromARGB(255, 22, 81, 190),
                                    fontSize: 16)),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                                "${course.maxLearner.toString()} " +
                                    "students".tr,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 248, 244, 244))),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(course.address,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 252, 252, 252))),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ))),
    );
  }
}
