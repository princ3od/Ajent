import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/services/course_service.dart';
import 'package:ajent/core/utils/date_converter.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchCourseCard extends StatelessWidget {
  final Course course;
  SearchCourseCard({@required this.course});
  @override
  Widget build(BuildContext context) {
    Color textColor = (course.hasTeacher()) ? Colors.black : Colors.white;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        color: (course.hasTeacher())
            ? Color.fromARGB(255, 246, 243, 243)
            : primaryColor,
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
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
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
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Posted".tr+" ${DateConverter.getTimeInAgo(course.postDate)}",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                                color: textColor.withOpacity(0.7)),
                          ),
                          Text(
                            "${course.getReadablePrice()}",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: textColor),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: SizedBox(
                        width: Get.width * 0.8,
                        child: Text(
                          course.name,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.nunitoSans(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.5),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: Get.width * 0.7,
                      child: Text(
                        course.getRelativeAddress(),
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: textColor.withOpacity(0.8)),
                      ),
                    ),
                  ],
                ),
                if (course.subjects.length > 0)
                  SizedBox(
                    height: 24,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: course.subjects.length,
                      itemBuilder: (context, index) {
                        return SubjectBadge(
                          content: course.subjects[index],
                          hasTeacher: course.hasTeacher(),
                        );
                      },
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

class SubjectBadge extends StatelessWidget {
  final String content;
  final bool hasTeacher;
  const SubjectBadge({Key key, @required this.content, this.hasTeacher})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: hasTeacher
                  ? primaryColor.withOpacity(0.10)
                  : Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
              child: Center(
                child: Text(content,
                    maxLines: 1,
                    style: GoogleFonts.nunitoSans(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
