import 'package:ajent/core/utils/date_converter.dart';
import 'package:flutter/material.dart';

class LessonTime {
  TimeOfDay startTime;
  TimeOfDay endTime;
  LessonTime();
  LessonTime.fromJson(Map<String, dynamic> data) {
    startTime = DateConverter.stringToTime(data['startTime']);
    endTime = DateConverter.stringToTime(data['endTime']);
  }

  Map<String, dynamic> toJson() {
    return {
      'startTime': DateConverter.timeToString(startTime),
      'endTime': DateConverter.timeToString(endTime),
    };
  }
}
