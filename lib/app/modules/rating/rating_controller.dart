import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/models/evaluation.dart';
import 'package:ajent/app/data/services/course_service.dart';
import 'package:ajent/app/modules/my_course_detail/my_course_detail_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RatingController extends GetxController {
  TextEditingController contentController = TextEditingController();
  var star = (5.0).obs;
  var isPosting = false.obs;
  Course course;
  @override
  onInit() {
    super.onInit();
    course = Get.arguments;
    if (course.evaluation.isEvaluate()) {
      contentController.text = course.evaluation.content;
      star.value = course.evaluation.star % 6.0;
    }
  }

  postEvaluation(String courseId) async {
    isPosting.value = true;
    Evaluation evaluation =
        Evaluation(star.value.toInt(), contentController.text);
    course.evaluation =
        await CourseService.instance.addEvaluation(courseId, evaluation);
    contentController.text = course.evaluation.content;
    star.value = course.evaluation.star % 5.0;
    Get.find<MyCourseDetailController>().course.update((val) {
      val.evaluation = evaluation;
    });
    isPosting.value = false;
    Get.dialog(AlertDialog(
      title: Text("Đăng đánh giá"),
      content:
          Text('Đánh giá của bạn đã được đăng, xin cảm ơn bạn vì đã đánh giá.'),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: Text("OK")),
      ],
    ));
  }
}
