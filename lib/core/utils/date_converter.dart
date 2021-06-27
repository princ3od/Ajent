import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../values/lang/localization_service.dart';

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
      return DateFormat("HH:mm, EE dd", LocalizationService.getLocaleString())
          .format(time);
    if (timeDistance.inDays.abs() < 365)
      return DateFormat((dateOnly) ? "MMM dd" : "HH:mm MMM dd",
              LocalizationService.getLocaleString())
          .format(time);
    return DateFormat((dateOnly) ? "MMM dd, yyyy" : "HH:mm MMM dd, yyyy",
            LocalizationService.getLocaleString())
        .format(time);
  }

  static String getTimeInDate(int timeStamp) {
    final time = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    return DateFormat("MMM dd, yyyy", LocalizationService.getLocaleString())
        .format(time);
  }

  static String getTimeInAgo(int timeStamp) {
    final now = DateTime.now();
    final time = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    final timeDistance = now.difference(time);
    if (timeDistance.inMinutes.abs() < 1) {
      return 'now'.tr;
    }
    if (timeDistance.inMinutes.abs() < 60)
      return timeDistance.inMinutes.abs().toString() + 'mm'.tr + 'ago'.tr;
    if (timeDistance.inHours.abs() < 24)
      return timeDistance.inHours.abs().toString() + 'hh'.tr + 'ago'.tr;
    if (timeDistance.inDays.abs() < 30)
      return timeDistance.inDays.abs().toString() + 'dd'.tr + 'ago'.tr;
    if (timeDistance.inDays.abs() < 365)
      return (timeDistance.inDays.abs() / 30).toString() + 'mm'.tr + 'ago'.tr;
    return DateFormat("MMM dd, yyyy", LocalizationService.getLocaleString())
        .format(time);
  }

  static List<String> weekDays() {
    return [
      DateTime(2000, 1, 3, 1),
      DateTime(2000, 1, 4, 1),
      DateTime(2000, 1, 5, 1),
      DateTime(2000, 1, 6, 1),
      DateTime(2000, 1, 7, 1),
      DateTime(2000, 1, 8, 1),
      DateTime(2000, 1, 9, 1)
    ]
        .map((day) => DateFormat("EEE", LocalizationService.getLocaleString())
            .format(day))
        .toList();
  }
}
