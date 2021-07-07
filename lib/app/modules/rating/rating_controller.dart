import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/models/evaluation.dart';
import 'package:ajent/app/data/services/course_service.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RatingController extends GetxController {
  TextEditingController contentController = TextEditingController();
  var evaluation = Evaluation();
  var evaluated = false.obs;
  var star = (5.0).obs;
  var isPosting = false.obs;
  Course course;
  AjentUser user = HomeController.mainUser;
  @override
  onInit() {
    super.onInit();
    course = Get.arguments;
    if (course.evaluations.containsKey(user.uid)) {
      evaluation = course.evaluations[user.uid];
      contentController.text = evaluation.content;
      evaluated.value = true;
    }
  }

  postEvaluation(String courseId) async {
    isPosting.value = true;
    evaluation = Evaluation()
      ..star = star.value.toInt()
      ..postDate = DateTime.now().millisecondsSinceEpoch
      ..evaluatorUid = user.uid
      ..content = contentController.text;
    await CourseService.instance.postEvaluation(courseId, user.uid, evaluation);
    evaluated.value = true;
    course.evaluations[user.uid] = evaluation;
    isPosting.value = false;
    Get.dialog(AlertDialog(
      title: Text("Send rating".tr),
      content:
          Text('Your rating is sent'.tr),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("OK")),
      ],
    ));
  }
}
