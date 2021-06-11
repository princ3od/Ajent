import 'package:ajent/core/utils/enum_converter.dart';
import 'package:intl/intl.dart';

import 'Student.dart';
import 'Period.dart';
import 'FixedTime.dart';
import 'Evaluation.dart';

class Course {
  String id;
  String name;
  String description;
  List<String> subjects = [];
  List<Student> students = [];
  TimeType timeType;
  String address;
  String owner;
  String teacher;
  List<Period> periods = [];
  FixedTime fixedTime;
  List<Evaluation> evaluations = [];
  String requirements;
  CourseStatus status;
  Course(this.id, this.name, this.description, this.timeType, this.address,
      this.owner, this.teacher, this.requirements,
      [this.subjects,
      this.students,
      this.periods,
      this.fixedTime,
      this.evaluations]);
  Course.fromJson(this.id, Map<String, dynamic> data) {
    description = data['description'];
    name = data['name'];
    timeType = EnumConverter.stringToTimeType(data['timeType']);
    address = data['address'];
    owner = data['owner'];
    teacher = data['teacher'];
    requirements = data['requirement'];
  }
  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'description': this.description,
      'timeType': EnumConverter.timeTypeToString(this.timeType),
      'address': this.address,
      'owner': this.owner,
      'teacher': this.teacher,
    };
  }

  String getTimeAsString() {
    String result = "";
    if (timeType == TimeType.fixedTime) {
      var dateText = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
      for (var i = 0; i < fixedTime.day.length; i++) {
        if (fixedTime.day[i]) {
          result += dateText[i];
          if (i < fixedTime.day.length - 1) {
            result += " - ";
          }
        }
      }
      result += ": " +
          fixedTime.lessonTime.startTime +
          " - " +
          fixedTime.lessonTime.endTime;
      result += " (" +
          DateFormat("dd/MM/yyyy").format(fixedTime.startDate) +
          " - " +
          DateFormat("dd/MM/yyyy").format(fixedTime.endDate) +
          ")";
    } else {
      for (var i = 0; i < periods.length; i++) {
        result +=
            "${i + 1}. ${DateFormat("dd/MM/yyyy").format(periods[i].date)}: " +
                periods[i].lessonTime.startTime +
                " - " +
                periods[i].lessonTime.endTime;
        result += "\n";
      }
    }
    return result;
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
