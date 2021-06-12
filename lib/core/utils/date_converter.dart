import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateConverter {
  static String timeToString(TimeOfDay time) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat("HH:mm");
    return format.format(dt);
  }

  static TimeOfDay stringToTime(String data) {
    return TimeOfDay(
        hour: int.parse(data.split(":")[0]),
        minute: int.parse(data.split(":")[1]));
  }
}
