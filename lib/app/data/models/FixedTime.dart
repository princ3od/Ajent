import 'package:ajent/core/utils/date_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
}
