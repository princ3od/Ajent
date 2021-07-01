import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:ajent/routes/pages.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TeachingCard extends StatelessWidget {
  final Course course;
  TeachingCard({@required this.course});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 2,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [primaryColor, Color.fromARGB(255, 255, 128, 64)])),
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
                            radius: 30.0,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: Get.width - 150,
                            child: Hero(
                              tag: '${course.id} name',
                              child: Material(
                                color: Colors.transparent,
                                child: Text(
                                  course.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ]))
                  ],
                )),
          )),
    );
  }
}
