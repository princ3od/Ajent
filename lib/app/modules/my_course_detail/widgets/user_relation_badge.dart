import 'package:ajent/app/data/models/course.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserRelationBadge extends StatelessWidget {
  final UserRelation relation;
  UserRelationBadge({Key key, @required this.relation}) : super(key: key);
  final Map<UserRelation, String> texts = {
    UserRelation.noRelation: "",
    UserRelation.joining: "Bạn là học viên của khoá học này",
    UserRelation.requesting: "Bạn đang ứng tuyển dạy khoá học này",
    UserRelation.teaching: "Bạn là giáo viên của khoá học này"
  };
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(seconds: 1),
      opacity: 1,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Center(
                  child: Text(texts[relation],
                      maxLines: 1,
                      style: GoogleFonts.nunitoSans(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
