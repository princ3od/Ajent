import 'package:ajent/core/utils/date_converter.dart';
import 'package:ajent/core/utils/enum_converter.dart';
import 'package:intl/intl.dart';

import 'Student.dart';
import 'Period.dart';
import 'FixedTime.dart';
import 'evaluation.dart';

class Course {
  String id;
  String name;
  String description;
  String photoUrl;
  List<String> subjects = [];
  List<Student> students = [];
  TimeType timeType;
  String address;
  String owner;
  String teacher;
  int price;
  List<Period> periods = [];
  FixedTime fixedTime;
  Evaluation evaluation = Evaluation(-1, null);
  String requirements;
  CourseStatus status;
  // Course(this.id, this.name, this.description, this.photoUrl, this.timeType,
  //     this.address, this.owner, this.teacher, this.price, this.requirements,
  //     [this.subjects,
  //     this.students,
  //     this.periods,
  //     this.fixedTime,
  //     this.evaluation]);
  Course();
  Course.fromJson(this.id, Map<String, dynamic> data) {
    description = data['description'];
    photoUrl = data['photoUrl'];
    name = data['name'];
    timeType = EnumConverter.stringToTimeType(data['timeType']);
    address = data['address'];
    owner = data['owner'];
    teacher = data['teacher'];
    price = data['price'];
    evaluation = Evaluation(data['evaluationStar'], data['evaluationContent']);
    requirements = data['requirements'];
  }
  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'description': this.description,
      'photoUrl': this.photoUrl,
      'timeType': EnumConverter.timeTypeToString(this.timeType),
      'address': this.address,
      'owner': this.owner,
      'teacher': this.teacher,
      'price': this.price,
      'evaluationStar': this.evaluation.star,
      'evaluationContent': this.evaluation.content,
      'requirements': this.requirements,
      'lastPeriod': getLastPeriod(),
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

  String getLastPeriod() {
    if (timeType == TimeType.fixedTime) {
      return "";
    }
    periods.sort((a, b) => a.date.compareTo(b.date));
    String date =
        DateFormat("dd/MM/yyyy").format(periods[periods.length - 1].date);
    return date;
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
