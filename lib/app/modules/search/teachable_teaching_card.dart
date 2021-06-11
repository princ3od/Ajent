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
        padding: const EdgeInsets.all(8.0),
        child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40)),
            elevation: 4,
            color: primaryColor,
            child: InkWell(
              onTap: () {
                Get.toNamed(Routes.MYCOURSEDETAIL);
              },
              child: Wrap(
                runSpacing: -20,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Expanded(
                          child: Text(
                            "Deutsch für Anfänger",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w700, fontSize: 14,color: Colors.white),
                          ),
                        ),
                      )),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          backgroundImage:
                          AssetImage("assets/images/ajent_logo.png"),
                          radius: 40.0,
                        ),
                      ),
                      Icon(Icons.monetization_on,color: Colors.white),
                      Text("1 000 000 đ",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w700,color: Colors.white))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(100, 0, 0, 20),
                    child: Row(
                      children: [
                        Icon(Icons.location_on,color: Colors.white),
                        Text("Quận 3",
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w700,color: Colors.white))
                      ],
                    ),
                  )
                ],
              )))
        );


  }
}