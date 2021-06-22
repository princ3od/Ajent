import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/services/course_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  TextEditingController txtSearch = TextEditingController();
  DocumentSnapshot last;
  Stream<QuerySnapshot> result;
  RxList<Course> courses;
  search() {
    result = CourseService.instance
        .searchCourse(keyword: txtSearch.text, isFirst: true, last: last);
  }
}
