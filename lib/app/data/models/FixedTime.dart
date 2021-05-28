import 'LessonTime.dart';

class FixedTime {
  List<bool> day = List.generate(7, (_) => false);
  DateTime startDate;
  DateTime endDate;
  LessonTime lessonTime;
}
