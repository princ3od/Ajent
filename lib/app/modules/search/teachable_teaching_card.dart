import 'package:ajent/core/values/colors.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TeachalbeTeachingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)),
            elevation: 4,
            color: primaryColor,
            child: InkWell(
              onTap: () {
                Get.toNamed(Routes.MYCOURSEDETAIL);
              },
              child: Row(

                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      backgroundImage:
                      AssetImage("assets/images/ajent_logo.png"),
                      radius: 40.0,
                    ),
                  ),
                  Flexible(
                    child: Column(
                        children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 80, 0),
                          child: Text(
                            "Ajent's Teaching",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w700, fontSize: 14,color: Colors.white),
                          ),
                        ),


                        SizedBox( height: 10),

                        Row( 
                          children: [
                          Icon(Icons.monetization_on,color: Colors.white),
                          Flexible(
                            child: Text(" 1 000 000 đ",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,color: Colors.white)),
                          )
                        ],
                        ),


                        SizedBox(height: 10),

                        Row( children: [
                          Icon(Icons.location_on,color: Colors.white),
                          Flexible(
                            child: Text("Quận 3",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,color: Colors.white)),
                          )
                        ],),
                        SizedBox(height: 10)
                      ],
                    ),
                  )
                ],
              )
        )));
  }
}