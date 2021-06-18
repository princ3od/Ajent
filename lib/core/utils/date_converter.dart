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

  static String getTime(int timeStamp) {
    final now = DateTime.now().toLocal();
    final time = DateTime.fromMillisecondsSinceEpoch(timeStamp).toLocal();
    final timeDistance = now.difference(time);
    if (timeDistance.inHours < 24) return DateFormat("HH:mm").format(time);
    if (timeDistance.inDays < 7) return DateFormat("HH:mm, EE dd").format(time);
    if (timeDistance.inDays < 365)
      return DateFormat("HH:mm dd/MM").format(time);
    return DateFormat("HH:mm, dd/MM/yyyy").format(time);
  }
}
