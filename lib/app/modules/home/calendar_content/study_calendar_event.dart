

import 'package:ajent/core/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudyCalendarEventCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 0,
          color: Color.fromARGB(255, 246, 245, 244),
          child: Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                    height: 123,
                    child: Container(
                      color: Colors.black,
                    ),
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  "Học",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w800, fontSize: 18,color: primaryColor),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(220, 0, 5, 0),
                                child: Align(
                                  child: Text("19:00",
                                     overflow: TextOverflow.ellipsis,
                                     style: GoogleFonts.nunitoSans(
                                         fontWeight: FontWeight.w700,color: Color.fromARGB(255, 180, 156, 156))),
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(" Ajent's Course",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w900,color: Colors.black, fontSize: 18)),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row( children: [
                            Flexible(
                              child: Text("Teacher's name",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w700,color: Color.fromARGB(255, 180, 156, 156))),
                            )
                          ],),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                          child: Row( children: [
                            Flexible(
                              child: Text("Study location",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w700,color: Color.fromARGB(255, 180, 156, 156))),
                            )
                          ],),
                        ),
                      ],
                    ),
                  )
                ],
              )
          )


      ),
    );

  }
}
