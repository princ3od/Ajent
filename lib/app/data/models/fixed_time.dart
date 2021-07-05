import 'package:ajent/core/utils/date_converter.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import 'lesson_time.dart';

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
    lessonTime = LessonTime()
      ..startTime = DateConverter.stringToTime(data['startTime'])
      ..endTime = DateConverter.stringToTime(data['endTime']);
  }
  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'startDate': DateFormat("dd/MM/yyyy").format(startDate),
      'endDate': DateFormat("dd/MM/yyyy").format(endDate),
      'startTime': DateConverter.timeToString(lessonTime.startTime),
      'endTime': DateConverter.timeToString(lessonTime.endTime),
    };
  }

  double getTotalTime() {
    int learnDay = 0;
    double baseLessonTime = lessonTime.getTotalTime();
    day.forEach((element) {
      if (element) learnDay += 1;
    });
    var diff = endDate.difference(startDate);
    return learnDay * baseLessonTime * (diff.inDays / 7).floor();
  }

  String getTimeDetail() {
    var diff = endDate.difference(startDate);
    if (diff.inDays < 45) {
      return '${(diff.inDays / 7).floor().toString()}' + 'week'.tr;
    }
    return '${(diff.inDays / 30).floor().toString()}' + 'MM'.tr;
  }
}
