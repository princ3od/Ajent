import 'package:intl/intl.dart';

import 'LessonTime.dart';

class Period {
  DateTime date;
  LessonTime lessonTime;
  Period(this.date, this.lessonTime);
  Period.fromJson(Map<String, dynamic> data) {
    date = DateFormat("dd/MM/yyyy").parse(data['date']);
    lessonTime = LessonTime(data['startTime'], data['endTime']);
  }
}
