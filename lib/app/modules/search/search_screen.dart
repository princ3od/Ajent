import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/modules/search/widgets/joinable_course_card.dart';
import 'package:ajent/app/modules/search/widgets/teachable_teaching_card.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'search_screen_controller.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchController controller = Get.put(SearchController());

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
          controller: controller.txtSearch,
          decoration: searchTextfieldDecoration,
          style: GoogleFonts.nunitoSans(fontSize: 14),
          onChanged: (value) {
            if (value.trim().isEmpty) return;
            controller.search();
            setState(() {});
          },
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(210, 0, 10, 10),
                  child: IconButton(
                    icon: Icon(Icons.filter_list),
                    onPressed: () {},
                  ))
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: controller.result,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(
                    child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator()),
                  );
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      Course course = Course.fromJson(
                          snapshot.data.docs[index].id,
                          snapshot.data.docs[index].data());
                      if (course.teacher == null || course.teacher.isEmpty)
                        return TeachalbeTeachingCard(course: course);
                      else
                        return JoinableCourseCard(course: course);
                    },
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
