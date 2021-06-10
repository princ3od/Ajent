import 'package:ajent/core/utils/enum_converter.dart';

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
