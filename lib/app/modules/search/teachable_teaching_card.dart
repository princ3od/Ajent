
import 'package:ajent/core/values/colors.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TeachalbeTeachingCard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          elevation: 4,
          color: primaryColor,
          child: InkWell(
              onTap: () {
                Get.toNamed(Routes.MYCOURSEDETAIL);
              },
              child: Wrap(
                spacing: -40,
                runSpacing: -20,
                // mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(265, 20, 0, 0),
                    child: Text("Dạy", style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.white)),
                  ),
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
                              "My Teaching Name",
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w700, fontSize: 14,color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.transparent,
                                    border: Border.all(color: Colors.white,width: 2.0)
                                ),
                                child: IconButton(
                                  onPressed: ()=> print("presses add"),
                                  icon: Icon(
                                    Icons.add,
                                    size: 33,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
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