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

  double getTotalTime() {
    double totalTime = (endTime.hour + (endTime.minute / 60)) -
        (startTime.hour + (startTime.minute / 60));
    return totalTime.abs();
  }

  @override
  String toString() {
    return "${DateConverter.timeToString(startTime)} - ${DateConverter.timeToString(endTime)}";
  }
}
