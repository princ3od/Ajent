
import 'package:ajent/routes/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class JoinableCourseCard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          elevation: 4,
          color: Color.fromARGB(255, 246, 245, 244),
          child: InkWell(
              onTap: () {
                Get.toNamed(Routes.MYCOURSEDETAIL);
              },
              child: Wrap(
                spacing: 10,
                runSpacing: 10,

                children: [
                  Center(
                      child: Row(
                          children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            backgroundImage:
                            AssetImage("assets/images/ajent_logo.png"),
                            radius: 40.0,
                          ),
                        ),
                        Text(
                          "Example",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w700, fontSize: 14),
                        ),
                      ]

                      )
                  ),

                ],
              )
          )

      ),
    );

  }
}