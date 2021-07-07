import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/services/user_service.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudyCalendarEventCard extends StatefulWidget {
  final Course course;

  const StudyCalendarEventCard({Key key, @required this.course})
      : super(key: key);

  @override
  _StudyCalendarEventCardState createState() => _StudyCalendarEventCardState();
}

class _StudyCalendarEventCardState extends State<StudyCalendarEventCard> {
  AjentUser teacher;
  getTeacher() async {
    teacher = await UserService.instance.getUser(widget.course.teacher);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
          elevation: 0,
          color: Color.fromARGB(255, 246, 245, 244),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "study".tr,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                                color: primaryColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                              "${widget.course.timeInCalendar.toString()}",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(255, 180, 156, 156))),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text("${widget.course.name}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                    fontSize: 16)),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          if (widget.course.hasTeacher())
                            Flexible(
                              child: FutureBuilder(
                                future: getTeacher(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Text(teacher.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w700,
                                            color: Color.fromARGB(
                                                255, 180, 156, 156)));
                                  }
                                  return SizedBox(
                                    height: 12,
                                    width: 12,
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                            )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(widget.course.address,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 180, 156, 156))),
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
