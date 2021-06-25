import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

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

  static String getTime(int timeStamp, [bool dateOnly = false]) {
    final now = DateTime.now();
    final time = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    final timeDistance = now.difference(time);
    if (timeDistance.inHours.abs() < 24)
      return DateFormat("HH:mm").format(time);
    if (timeDistance.inDays.abs() < 7)
      return DateFormat("HH:mm, EE dd").format(time);
    if (timeDistance.inDays.abs() < 365)
      return DateFormat((dateOnly) ? "MMM dd" : "HH:mm MMM dd").format(time);
    return DateFormat((dateOnly) ? "MMM dd, yyyy" : "HH:mm MMM dd, yyyy")
        .format(time);
  }

  static String getTimeInAgo(int timeStamp) {
    final now = DateTime.now();
    final time = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    final timeDistance = now.difference(time);
    if (timeDistance.inMinutes.abs() < 1)
      return timeDistance.inMinutes.abs().toString() + 'ss'.tr + 'ago'.tr;
    if (timeDistance.inMinutes.abs() < 60)
      return timeDistance.inMinutes.abs().toString() + 'mm'.tr + 'ago'.tr;
    if (timeDistance.inHours.abs() < 24)
      return timeDistance.inHours.abs().toString() + 'hh'.tr + 'ago'.tr;
    if (timeDistance.inDays.abs() < 30)
      return timeDistance.inDays.abs().toString() + 'dd'.tr + 'ago'.tr;
    if (timeDistance.inDays.abs() < 365)
      return (timeDistance.inDays.abs() / 30).toString() + 'mm'.tr + 'ago'.tr;
    return DateFormat("MMM dd, yyyy").format(time);
  }
}
