import 'dart:io';

import 'package:ajent/app/data/models/FixedTime.dart';
import 'package:ajent/app/data/models/LessonTime.dart';
import 'package:ajent/app/data/models/Student.dart';
import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/models/Period.dart';
import 'package:ajent/app/data/services/course_service.dart';
import 'package:ajent/app/data/services/storage_service.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/app/modules/learning/learning_controlller.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddCourseController extends GetxController {
  var topics = ['Toán', 'Tiếng anh'];
  var selectedTopic = 'Toán'.obs;

  var courseTypes = ['Học nhóm'];
  var selectedType = 'Học nhóm'.obs;

  var timeTypes = [TimeType.fixedTime, TimeType.periodTime];
  var selectedTimeType = TimeType.fixedTime.obs;

  RxList<Period> periods = RxList<Period>();

  var days = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
  List<String> selectedDays;

  var startDate = DateTime.now().obs;
  var endDate = DateTime.now().obs;

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
    }
  }

  onAddCourse() async {
    isAddingCourse.value = true;
    String imageUrl = '';
    imagePath.value = '';
    if (imagePath.value != null && imagePath.value.isNotEmpty)
      imageUrl = await StorageService.instance
          .uploadCourseImage(File(imagePath.value));
    if (imageUrl != null) {
      Course course;
      try {
        course = Course()
          ..name = txtCourseName.text
          ..description = txtCourseDescription.text
          ..students =
              List.generate(int.parse(txtStudentNum.text), (index) => null)
          ..price = int.parse(txtCoursePrice.text)
          ..address = txtCourseAddress.text
          ..timeType = selectedTimeType.value
          ..requirements = txtCourseRequirements.text
          ..photoUrl = imageUrl;
      } catch (e) {
        Get.snackbar(
            "Lỗi dữ liệu", "Vui lòng kiểm tra lại thông tin khoá học.");
        isAddingCourse.value = false;
        return;
      }
      if (pageIndex == 1) {
        course.teacher = '';
        course.owner = HomeController.mainUser.uid;
      } else {
        course.teacher = HomeController.mainUser.uid;
        course.owner = '';
      }
      if (selectedTimeType.value == TimeType.periodTime)
        course.periods = periods;
      else
        course.fixedTime = FixedTime(
          List.generate(7, (index) => true),
          startDate.value,
          endDate.value,
          LessonTime(
            TimeOfDay(hour: 12, minute: 00),
            TimeOfDay(hour: 14, minute: 30),
          ),
        );
      course = await CourseService.instance.addCourse(course);
      if (course != null) {
        isAddingCourse.value = false;
        course.status = CourseStatus.upcoming;
        Get.snackbar("Thông báo", "Thêm khoá học thành công!");
        await Future.delayed(Duration(seconds: 1));
        await Get.find<LearningController>().fetchCourses();
        if (pageIndex == 1) {
          Get.offAndToNamed(Routes.MYCOURSEDETAIL, arguments: course);
        } else {
          Get.offAndToNamed(Routes.MYTEACHINGDETAIL, arguments: course);
        }
      } else {
        Get.snackbar("Lỗi", "Thêm khoá học thất bại!");
        isAddingCourse.value = false;
      }
    }
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
