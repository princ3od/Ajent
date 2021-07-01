import 'dart:io';

import 'package:ajent/app/data/models/FixedTime.dart';
import 'package:ajent/app/data/models/LessonTime.dart';
import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/models/Period.dart';
import 'package:ajent/app/data/services/course_service.dart';
import 'package:ajent/app/data/services/storage_service.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/app/modules/learning/learning_controlller.dart';
import 'package:ajent/app/modules/my_course_detail/my_course_detail_page.dart';
import 'package:ajent/app/modules/my_teaching_detail/my_teaching_detail_page.dart';
import 'package:ajent/app/modules/teaching/teaching_controller.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddCourseController extends GetxController {
  List<String> subjects = [];

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
  var imagePath = ''.obs;

  var isAddingCourse = false.obs;

  final pageIndex;
  AddCourseController(this.pageIndex);
  onChangeCouseImage() async {
    String path = await _getImage();
    if (path != null) {
      imagePath.value = path;
      print(path);
    }
  }

  onAddCourse() async {
    if (isAddingCourse.value) {
      return;
    }
    isAddingCourse.value = true;
    String imageUrl = '';
    if (imagePath.value != null && imagePath.value.isNotEmpty)
      imageUrl = await StorageService.instance
          .uploadCourseImage(File(imagePath.value));
    if (imageUrl != null) {
      Course course;
      try {
        course = Course()
          ..name = txtCourseName.text
          ..owner = HomeController.mainUser.uid
          ..description = txtCourseDescription.text
          ..maxLearner = num.parse(txtStudentNum.text)
          ..price = int.parse(txtCoursePrice.text.replaceAll(".", ""))
          ..address = txtCourseAddress.text
          ..timeType = selectedTimeType.value
          ..requirements = txtCourseRequirements.text
          ..photoUrl = imageUrl
          ..subjects = subjects;
      } catch (e) {
        Get.snackbar(
            "Lỗi dữ liệu", "Vui lòng kiểm tra lại thông tin khoá học.");
        isAddingCourse.value = false;
        return;
      }
      if (pageIndex == 1) {
        course.teacher = '';
        course.learners.add(HomeController.mainUser.uid);
      } else {
        course.teacher = HomeController.mainUser.uid;
        course.learners = [];
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
      course = await CourseService.instance.addCourse(course);
      if (course != null) {
        course.status = CourseStatus.upcoming;
        if (pageIndex == 1) {
          Get.find<LearningController>().onTabChanged(course.status.index);
          Get.find<LearningController>().fetchCourses();
          Get.offNamed(Routes.MYCOURSEDETAIL, arguments: course);
        } else {
          Get.find<TeachingController>().onTabChanged(course.status.index);
          Get.find<TeachingController>().fetchCourses();
          Get.offNamed(Routes.MYTEACHINGDETAIL, arguments: course);
        }
        isAddingCourse.value = false;
      } else {
        Get.snackbar("Lỗi", "Thêm khoá học thất bại!");
        isAddingCourse.value = false;
      }
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

  Future<String> _getImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return pickedFile.path;
    } else {
      print('No image selected.');
      return null;
    }
  }
}
