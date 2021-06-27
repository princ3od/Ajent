import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/services/course_service.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class JoinableCourseCard extends StatelessWidget {
  final Course course;
  JoinableCourseCard({@required this.course});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Card(
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            elevation: 4,
            color: Color.fromARGB(255, 246, 243, 243),
            child: InkWell(
                onTap: () async {
                  Course fullCourse =
                      await CourseService.instance.getCourse(course.id);
                  Get.toNamed(Routes.MYCOURSEDETAIL, arguments: fullCourse);
                },
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Hero(
                        tag: '${course.id} avatar',
                        child: CircleAvatar(
                          child: ClipOval(
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/ajent_logo.png',
                              image: course.photoUrl,
                              width: 100,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          radius: 40.0,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 80, 0),
                            child: Hero(
                              tag: '${course.id} name',
                              child: Material(
                                color: Colors.transparent,
                                child: Text(
                                  course.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.monetization_on),
                              Flexible(
                                child: Text(course.getReadablePrice(),
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w700)),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.location_on),
                              Flexible(
                                child: Text(course.address,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w700)),
                              )
                            ],
                          ),
                          SizedBox(height: 10)
                        ],
                      ),
                    )
                  ],
                ))));
  }
}
