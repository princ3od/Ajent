import 'package:ajent/app/data/models/Course.dart';
import 'package:ajent/app/data/models/Period.dart';
import 'package:get/get.dart';

class AddCourseController extends GetxController{
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
}