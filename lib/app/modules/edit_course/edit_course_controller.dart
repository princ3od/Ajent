import 'dart:io';

import 'package:ajent/app/data/models/fixed_time.dart';
import 'package:ajent/app/data/models/lesson_time.dart';
import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/models/Period.dart';
import 'package:ajent/app/data/services/course_service.dart';
import 'package:ajent/app/data/services/subscribe_service.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/app/modules/my_course_detail/my_course_detail_controller.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:textfield_tags/textfield_tags.dart';

class EditCourseController extends GetxController {
  var subjects = <String>[].obs;

  var timeTypes = [TimeType.fixedTime, TimeType.periodTime];
  var selectedTimeType = TimeType.fixedTime.obs;

  RxList<Period> periods = RxList<Period>();

  List<String> selectedDays;
  var days = List.generate(7, (index) => false);
  var startTime = TimeOfDay(hour: 7, minute: 0).obs;
  var endTime = TimeOfDay(hour: 9, minute: 0).obs;

  var startDate = DateTime.now().obs;
  var endDate = DateTime.now().obs;
  var lessionTime = LessonTime();

  RxList<String> learners = RxList<String>();

  TextEditingController txtCourseName = TextEditingController();
  TextEditingController txtCourseDescription = TextEditingController();
  TextEditingController txtStudentNum = TextEditingController();
  TextEditingController txtCoursePrice = TextEditingController();
  TextEditingController txtCourseAddress = TextEditingController();
  TextEditingController txtCourseRequirements = TextEditingController();
  TextfieldTagsController tagsController = TextfieldTagsController();

  var isUpdating = false.obs;

  final Course course;
  EditCourseController(this.course) {
    selectedTimeType.value = course.timeType;
    if (course.timeType == TimeType.fixedTime) {
      days = course.fixedTime.day;
      startTime.value = course.fixedTime.lessonTime.startTime;
      endTime.value = course.fixedTime.lessonTime.endTime;
      startDate.value = course.fixedTime.startDate;
      endDate.value = course.fixedTime.endDate;
    } else {
      periods.value = course.periods;
    }
    learners.value = course.learners;
    txtCourseName.text = course.name;
    txtCourseDescription.text = course.description;
    txtStudentNum.text = course.maxLearner.toString();
    txtCoursePrice.text = formatCurrencyText(course.price.toString());
    txtCourseAddress.text = course.address;
    txtCourseRequirements.text = course.requirements;
    subjects.value = course.subjects;
  }

  onEditCourse() async {
    if (isUpdating.value) {
      return;
    }
    isUpdating.value = true;

    try {
      course
        ..name = txtCourseName.text
        ..description = txtCourseDescription.text
        ..maxLearner = num.parse(txtStudentNum.text)
        ..price = int.parse(txtCoursePrice.text.replaceAll(".", ""))
        ..address = txtCourseAddress.text
        ..timeType = selectedTimeType.value
        ..requirements = txtCourseRequirements.text
        ..photoUrl = course.photoUrl ?? ""
        ..subjects = tagsController.getTags;
      if (course.maxLearner < course.learners.length || course.price < 0) {
        Get.snackbar("data_error".tr, "check_course_info_warning".tr);
        isUpdating.value = false;
        return;
      }
    } catch (e) {
      print(e);
      Get.snackbar("data_error".tr, "check_course_info_warning".tr);
      isUpdating.value = false;
      return;
    }

    if (selectedTimeType.value == TimeType.periodTime)
      course.periods = periods;
    else {
      lessionTime
        ..startTime = startTime.value
        ..endTime = endTime.value;
      course.fixedTime = FixedTime(
        days,
        startDate.value,
        endDate.value,
        lessionTime,
      );
    }
    Course _course = await CourseService.instance.editCourse(course);
    if (_course != null) {
      isUpdating.value = false;
      Get.offAndToNamed(Routes.MYCOURSEDETAIL, arguments: course);
      Get.find<HomeController>().fetch();
    } else {
      Get.snackbar("error".tr, "add_course_fail".tr);
      isUpdating.value = false;
    }
  }

  formatCurrencyText(String value) {
    if (value.isEmpty) {
      txtCoursePrice.clear();
      return;
    }
    txtCoursePrice.text = NumberFormat("#,###")
        .format(num.parse(value.replaceAll(".", "")))
        .replaceAll(",", ".");
    txtCoursePrice.selection = TextSelection(
        baseOffset: txtCoursePrice.text.length,
        extentOffset: txtCoursePrice.text.length);
  }
}
