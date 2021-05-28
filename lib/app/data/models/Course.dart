import 'Student.dart';
import 'Period.dart';
import 'FixedTime.dart';
import 'Evaluation.dart';

class Course {
  String id;
  String name;
  List<String> subjects;
  List<Student> students;
  TimeType timeType;
  String address;
  String owner;
  String teacher;
  List<Period> periods;
  FixedTime fixedTime;
  List<Evaluation> evaluations;
  String requirements;
}

enum TimeType {
  periodTime,
  fixedTime,
}
