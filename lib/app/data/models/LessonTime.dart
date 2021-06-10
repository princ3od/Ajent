class LessonTime {
  String startTime;
  String endTime;
  LessonTime(this.startTime, this.endTime);
  LessonTime.fromJson(Map<String, dynamic> data) {
    startTime = data['startTime'];
    endTime = data['endTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}
