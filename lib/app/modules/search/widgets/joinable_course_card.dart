import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/services/course_service.dart';
import 'package:ajent/core/utils/date_converter.dart';
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
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        color: Color.fromARGB(255, 246, 243, 243),
        child: InkWell(
          onTap: () async {
            BuildContext dialogContext;
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                dialogContext = context;
                return AlertDialog(
                  title: Center(
                      child: SizedBox(
                          height: 20,
                          width: 20,
                          child: new CircularProgressIndicator())),
                );
              },
            );
            Course fullCourse =
                await CourseService.instance.getCourse(course.id);
            Navigator.pop(dialogContext);
            Get.toNamed(Routes.MYCOURSEDETAIL, arguments: fullCourse);
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Hero(
                        tag: '${course.id} avatar',
                        child: CircleAvatar(
                          child: ClipOval(
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/ajent_logo.png',
                              image: course.photoUrl,
                              width: 80,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          radius: 24.0,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Hero(
                          tag: '${course.id} name',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              course.name,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          course.getRelativeAddress(),
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Sent ".tr+"${DateConverter.getTimeInAgo(course.postDate)}",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            color: Colors.black54),
                      ),
                      Text(
                        "${course.getReadablePrice()}",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Colors.black),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          // child: Row(
          //   children: [
          //     Padding(
          //       padding: EdgeInsets.all(15.0),
          //       child: Hero(
          //         tag: '${course.id} avatar',
          //         child: CircleAvatar(
          //           child: ClipOval(
          //             child: FadeInImage.assetNetwork(
          //               placeholder: 'assets/images/ajent_logo.png',
          //               image: course.photoUrl,
          //               width: 100,
          //               fit: BoxFit.fitWidth,
          //             ),
          //           ),
          //           radius: 40.0,
          //         ),
          //       ),
          //     ),
          //     Flexible(
          //       child: Column(
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.fromLTRB(0, 10, 80, 0),
          //             child: Hero(
          //               tag: '${course.id} name',
          //               child: Material(
          //                 color: Colors.transparent,
          //                 child: Text(
          //                   course.name,
          //                   overflow: TextOverflow.ellipsis,
          //                   style: GoogleFonts.nunitoSans(
          //                       fontWeight: FontWeight.w700, fontSize: 14),
          //                 ),
          //               ),
          //             ),
          //           ),
          //           SizedBox(height: 10),
          //           Row(
          //             children: [
          //               Icon(Icons.monetization_on),
          //               Flexible(
          //                 child: Text(course.getReadablePrice(),
          //                     overflow: TextOverflow.ellipsis,
          //                     style: GoogleFonts.nunitoSans(
          //                         fontWeight: FontWeight.w700)),
          //               )
          //             ],
          //           ),
          //           SizedBox(height: 10),
          //           Row(
          //             children: [
          //               Icon(Icons.location_on),
          //               Flexible(
          //                 child: Text(course.address,
          //                     overflow: TextOverflow.ellipsis,
          //                     style: GoogleFonts.nunitoSans(
          //                         fontWeight: FontWeight.w700)),
          //               )
          //             ],
          //           ),
          //           SizedBox(height: 10)
          //         ],
          //       ),
          //     )
          //   ],
          // ),
        ),
      ),
    );
  }
}
