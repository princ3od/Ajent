import 'package:intl/intl.dart';

import 'LessonTime.dart';

class FixedTime {
  List<bool> day = List.generate(7, (_) => false);
  DateTime startDate;
  DateTime endDate;
  LessonTime lessonTime;
  FixedTime(this.day, this.startDate, this.endDate, this.lessonTime);
  FixedTime.fromJson(Map<String, dynamic> data) {
    day = List<bool>.from(data['day']);
    startDate = DateFormat("dd/MM/yyyy").parse(data['startDate']);
    endDate = DateFormat("dd/MM/yyyy").parse(data['endDate']);
    lessonTime = LessonTime(data['startTime'], data['endTime']);
  }
}
