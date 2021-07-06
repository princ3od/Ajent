import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/global_widgets/user_avatar.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CoursePersonnel extends StatelessWidget {
  final AjentUser teacher;
  final List<AjentUser> learners;
  CoursePersonnel({@required this.teacher, @required this.learners});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 15, 10),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Teacher".tr,
                    style: GoogleFonts.nunitoSans(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  if (teacher != null)
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.PROFILEVIEW, arguments: teacher);
                      },
                      child: Row(
                        children: [
                          UserAvatar(user: teacher, size: 16),
                          SizedBox(width: 10),
                          SizedBox(
                            width: Get.width / 2 - 50,
                            child: Tooltip(
                              message: teacher.name,
                              child: Text(
                                teacher.name,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        "Not available".tr,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nunitoSans(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                ],
              ),
            ),
            VerticalDivider(
              color: Colors.grey,
            ),
            Expanded(
              flex: (teacher != null) ? 2 : 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Student "+"(${learners.length})",
                    style: GoogleFonts.nunitoSans(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      if (learners.length > 0)
                        Tooltip(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: UserAvatar(user: learners[0], size: 12),
                          ),
                          message: learners[0].name,
                          preferBelow: false,
                        ),
                      if (learners.length > 1)
                        Tooltip(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: UserAvatar(user: learners[1], size: 12),
                          ),
                          message: learners[1].name,
                          preferBelow: false,
                        ),
                      if (learners.length > 2)
                        Tooltip(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: UserAvatar(user: learners[2], size: 12),
                          ),
                          message: learners[2].name,
                          preferBelow: false,
                        ),
                      if (learners.length > 3)
                        Tooltip(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: UserAvatar(user: learners[3], size: 12),
                          ),
                          message: learners[3].name,
                          preferBelow: false,
                        ),
                      if (learners.length > 4) Text("..."),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
