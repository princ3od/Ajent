import 'package:ajent/app/modules/search/teachable_teaching_card.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'joinable_course_card.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        toolbarHeight: 55,
        title: TextFormField(
          autofocus: true,
          decoration: searchTextfieldDecoration,
          style: GoogleFonts.nunitoSans(
            fontSize: 14
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: ElevatedButton(
                        style: orangeButtonStyle,
                        child: Text("Mở lớp",
                            style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w700, fontSize: 11)),
                          onPressed: () {},
                        ),
                      ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(130, 10, 10, 10),
                        child: IconButton(
                          icon: Icon(
                            Icons.filter_list
                          ),
                          onPressed: (){},
                        )
                    )
                  ],
                ),
                JoinableCourseCard(),
                TeachalbeTeachingCard()
              ]
          ),
        ),
      ),
    );
  }
}
