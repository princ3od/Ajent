import 'Person.dart';
import 'Degree.dart';
import 'Student.dart';

class AjentUser extends Person {
  String uid;
  String avatarUrl;
  String schoolName;
  String major;
  String educationLevel;
  List<String> subjects;
  String bio;
  List<Degree> degrees;
  List<Student> students;
}
