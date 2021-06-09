
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
                spacing: -40,
                runSpacing: -20,
                // mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(250, 20, 0, 0),
                    child: Text("Học", style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold,fontSize: 13)),
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
                          "My Course Name",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w700, fontSize: 14),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              border: Border.all(color: Colors.black,width: 2.0)
                            ),
                            child: IconButton(
                              onPressed: ()=> print("presses add"),
                              icon: Icon(
                                Icons.add,
                                size: 33,
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