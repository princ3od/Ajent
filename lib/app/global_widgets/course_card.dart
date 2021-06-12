import 'package:ajent/app/data/models/Course.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  CourseCard({Key key, @required this.course});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          elevation: 4,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color.fromARGB(150, 229, 222, 222),
                  Colors.white10,
                  Colors.white
                ])),
            child: InkWell(
                onTap: () {
                  Get.toNamed(Routes.MYCOURSEDETAIL, arguments: course);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Row(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/ajent_logo.png"),
                          radius: 40.0,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          course.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w700, fontSize: 14),
                        ),
                      )
                    ]))
                  ],
                )),
          )),
    );
  }
}
