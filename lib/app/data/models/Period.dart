import 'package:ajent/core/utils/date_converter.dart';
import 'package:intl/intl.dart';

import 'LessonTime.dart';

class Period {
  DateTime date;
  LessonTime lessonTime;
  Period(this.date, this.lessonTime);
  Period.fromJson(Map<String, dynamic> data) {
    date = DateFormat("dd/MM/yyyy").parse(data['date']);
    lessonTime = LessonTime(DateConverter.stringToTime(data['startTime']),
        DateConverter.stringToTime(data['endTime']));
  }
  Map<String, dynamic> toJson() {
    return {
      'date': DateFormat("dd/MM/yyyy").format(date),
      'startTime': DateConverter.timeToString(lessonTime.startTime),
      'endTime': DateConverter.timeToString(lessonTime.endTime),
    };
  }
}
