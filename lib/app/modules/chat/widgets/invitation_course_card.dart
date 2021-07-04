import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/services/course_service.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class InvitationCourseCard extends StatelessWidget {
  final String courseId;
  InvitationCourseCard({Key key, @required this.courseId}) : super(key: key);

  Course course;

  _getCourse() async {
    course = await CourseService.instance.getCourse(courseId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.7,
      height: 140,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
          onTap: () {
            if (course != null)
              Get.toNamed(Routes.MYCOURSEDETAIL, arguments: course);
          },
          child: FutureBuilder(
            future: _getCourse(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AnimatedOpacity(
                  duration: Duration(milliseconds: 600),
                  opacity: (course != null) ? 1 : 0,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 5, 10),
                                child: Hero(
                                  tag: '$courseId avatar',
                                  child: CircleAvatar(
                                    child: ClipOval(
                                      child: FadeInImage.assetNetwork(
                                        fadeInDuration:
                                            Duration(milliseconds: 200),
                                        fadeOutDuration:
                                            Duration(milliseconds: 180),
                                        placeholder:
                                            'assets/images/ajent_logo.png',
                                        image: course?.photoUrl ?? "",
                                        width: 80,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    radius: 20,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Hero(
                                      tag: '${courseId} name',
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Text(
                                          (course?.name ?? "--------"),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.nunitoSans(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      course.getRelativeAddress(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: 10,
                                        color: Colors.white.withOpacity(0.6),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: Column(
                              children: [
                                Text(
                                  course.description,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 12,
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                ),
                                SizedBox(height: 5),
                                if (course.subjects.length > 0)
                                  SizedBox(
                                    height: 20,
                                    child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: course.subjects.length,
                                      itemBuilder: (context, index) {
                                        return SubjectBadge(
                                          content: course.subjects[index],
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Center(
                child: SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class SubjectBadge extends StatelessWidget {
  final String content;
  const SubjectBadge({Key key, @required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.20),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
              child: Center(
                child: Text(content,
                    maxLines: 1,
                    style: GoogleFonts.nunitoSans(
                        color: Colors.black.withOpacity(0.9),
                        fontSize: 8,
                        fontWeight: FontWeight.w700)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
