import 'package:ajent/app/data/models/lesson_time.dart';
import 'package:ajent/core/utils/date_converter.dart';
import 'package:ajent/core/utils/enum_converter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Period.dart';
import 'fixed_time.dart';
import 'evaluation.dart';

class Course {
  String id;
  String name;
  String description;
  String photoUrl;
  List<String> subjects = [];
  List<String> learners = [];
  TimeType timeType;
  String address;
  String owner;
  String teacher;
  int price;
  int maxLearner;
  List<Period> periods = [];
  FixedTime fixedTime;
  Map<String, Evaluation> evaluations = Map<String, Evaluation>();
  String requirements;
  CourseStatus status;
  int postDate;
  LessonTime timeInCalendar;
  Course(
      {this.id,
      this.name,
      this.description,
      this.photoUrl,
      this.timeType,
      this.address,
      this.owner,
      this.teacher,
      this.price,
      this.requirements,
      this.subjects,
      this.maxLearner,
      this.periods,
      this.fixedTime,
      this.evaluations});
  Course.fromJson(this.id, Map<String, dynamic> data) {
    description = data['description'];
    photoUrl = data['photoUrl'];
    name = data['name'];
    timeType = EnumConverter.stringToTimeType(data['timeType']);
    address = data['address'];
    owner = data['owner'];
    teacher = data['teacher'];
    price = data['price'];
    learners = List.from(data['learners']);
    subjects = List.from(data['subjects']);
    maxLearner = data['maxLearners'];
    postDate = data['postDate'];
    requirements = data['requirements'];
    subjects.removeWhere((element) => element.isEmpty);
  }
  Map<String, dynamic> toJson() {
    if (timeType == TimeType.periodTime) {
      periods.sort((a, b) => a.date.compareTo(b.date));
      subjects.removeWhere((element) => element.isEmpty);
    }
    return {
      'name': this.name,
      'description': this.description,
      'photoUrl': this.photoUrl,
      'timeType': EnumConverter.timeTypeToString(this.timeType),
      'address': this.address,
      'owner': this.owner,
      'teacher': this.teacher,
      'price': this.price,
      'maxLearners': this.maxLearner,
      'learners': this.learners,
      'subjects': this.subjects,
      'requirements': this.requirements,
      'postDate': DateTime.now().millisecondsSinceEpoch,
      'firstPeriod': getFirstPeriod(),
      'lastPeriod': getLastPeriod(),
      'indexList': getIndexList(),
    };
  }

  String getTimeAsString() {
    String result = "";
    if (timeType == TimeType.fixedTime) {
      var dateText = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
      for (var i = 0; i < fixedTime.day.length; i++) {
        if (fixedTime.day[i]) {
          result += dateText[i];
          if (i < fixedTime.day.length - 1) {
            result += " - ";
          }
        }
      }
      result += ": " +
          DateConverter.timeToString(fixedTime.lessonTime.startTime) +
          " - " +
          DateConverter.timeToString(fixedTime.lessonTime.endTime);
      result += " (" +
          DateFormat("dd/MM/yyyy").format(fixedTime.startDate) +
          " - " +
          DateFormat("dd/MM/yyyy").format(fixedTime.endDate) +
          ")";
    } else {
      for (var i = 0; i < periods.length; i++) {
        result +=
            "${i + 1}. ${DateFormat("dd/MM/yyyy").format(periods[i].date)}: " +
                DateConverter.timeToString(periods[i].lessonTime.startTime) +
                " - " +
                DateConverter.timeToString(periods[i].lessonTime.endTime);
        result += "\n";
      }
    }
    return result;
  }

  bool hasTeacher() {
    return (teacher != null && teacher.isNotEmpty);
  }

  String getLastPeriod() {
    if (timeType == TimeType.fixedTime) {
      return "";
    }
    String date =
        DateFormat("dd/MM/yyyy").format(periods[periods.length - 1].date);
    return date;
  }

  String getFirstPeriod() {
    if (timeType == TimeType.fixedTime) {
      return "";
    }
    String date = DateFormat("dd/MM/yyyy").format(periods[0].date);
    return date;
  }

  List<String> getIndexList() {
    List<String> result = [];
    List<String> words = name.split(' ').toList();
    for (var word in words) {
      for (var i = 1; i < word.length + 1; i++) {
        result.add(word.substring(0, i).toLowerCase());
      }
    }
    for (var i = 0; i < words.length - 1; i++) {
      String word = words[i];
      for (var j = i + 1; j < words.length; j++) {
        word += " " + words[j];
        result.add(word.toLowerCase());
      }
    }
    return result;
  }

  String getReadablePrice() {
    if (price == null) price = 0;
    return NumberFormat.currency(locale: "vi_VN", symbol: "vnd").format(price);
  }

  CourseStatus getCourseStatus() {
    DateTime now = DateTime.now();
    if (timeType == TimeType.fixedTime) {
      if (now.isAfter(fixedTime.endDate.add(Duration(days: 1)))) {
        status = CourseStatus.fininished;
      } else if (now.isBefore(fixedTime.startDate)) {
        status = CourseStatus.upcoming;
      } else {
        status = CourseStatus.ongoing;
      }
    } else {
      if (now
          .isAfter(periods[periods.length - 1].date.add(Duration(days: 1)))) {
        status = CourseStatus.fininished;
      } else if (now.isBefore(periods[0].date)) {
        status = CourseStatus.upcoming;
      } else {
        status = CourseStatus.ongoing;
      }
    }
    if ((teacher == null || teacher.isEmpty || learners.length <= 0) &&
        status != CourseStatus.fininished) {
      status = CourseStatus.upcoming;
    }
    return status;
  }

  double getTotalHours() {
    double result = 0;
    if (timeType == TimeType.periodTime) {
      for (var period in periods) {
        result += period.lessonTime.getTotalTime();
      }
    } else {
      result = fixedTime.getTotalTime();
    }
    return result;
  }

  String getRelativeAddress() {
    var addressPart = address.split(',');
    int startPart = addressPart.length > 2 ? addressPart.length - 2 : 0;
    String result = "";
    for (var i = startPart; i < addressPart.length; i++) {
      result += addressPart[i].trim();
      if (i < addressPart.length - 1) result += ", ";
    }
    return result;
  }

  bool isInCalendar(int selectedDay) {
    var date = DateTime.now()
        .add(Duration(days: selectedDay + 1 - DateTime.now().weekday));
    if (timeType == TimeType.fixedTime) {
      if (fixedTime.day[date.weekday - 1]) {
        timeInCalendar = fixedTime.lessonTime;
        return true;
      }
    } else {
      for (var period in periods) {
        if (period.date.isSameDate(date)) {
          timeInCalendar = period.lessonTime;
          return true;
        }
      }
    }
    return false;
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}

enum TimeType {
  periodTime,
  fixedTime,
}

enum CourseStatus {
  fininished,
  ongoing,
  upcoming,
}

enum UserRelation {
  noRelation,
  teaching,
  joining,
  requesting,
}
