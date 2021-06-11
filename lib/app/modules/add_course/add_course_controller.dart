import 'package:ajent/app/data/models/Period.dart';
import 'package:get/get.dart';

class AddCourseController extends GetxController{
  var topics = ['Toán', 'Tiếng anh'];
  var selectedTopic = 'Toán'.obs;

  var courseTypes = ['Học nhóm'];
  var selectedType = 'Học nhóm'.obs;

  var timeTypes = ['Theo buổi', 'Cố định'];
  var selectedTimeType = 'Theo buổi'.obs;

  RxList<Period> periods = RxList<Period>();

  var startDate = DateTime.now().obs;
  var endDate = DateTime.now().obs;

  RxList<String> learners = RxList<String>();
}