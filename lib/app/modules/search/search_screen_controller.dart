import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/services/course_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  TextEditingController txtSearch = TextEditingController();
  int length = 8;
  int currentLength = -1, previousLength = -1;
  bool loadMore = true;
  Stream<QuerySnapshot> result;
  List<String> options = [
    "Chưa có giáo viên",
    "Đã có giáo viên",
    "dsaafsadsad"
  ];
  List<dynamic> tags = [
    "Chưa có giáo viên",
    "Đã có giáo viên",
  ];
  @override
  onInit() {
    super.onInit();
  }

  search() async {
    result = CourseService.instance.searchCourse(
        keyword: txtSearch.text.trim().toLowerCase(), maxLength: length);
  }

  resetSearch() {
    loadMore = true;
    length = 8;
    currentLength = previousLength = -1;
  }

  showFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          children: [Expanded(child: Center(child: Text("Filter")))],
        );
      },
    );
  }
}
