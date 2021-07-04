import 'package:ajent/core/utils/enum_converter.dart';

class NotificationModel {
  String id;
  String courseId;
  String imageUrl;
  String content;
  int postDate;
  List<String> receivers;
  NotificationAction action;
  NotificationModel(
      {this.id, this.courseId, this.content, this.postDate, this.action});
  NotificationModel.fromJson(String id, Map<String, dynamic> data) {
    this.id = id;
    this.imageUrl = data['imageUrl'];
    this.courseId = data['courseId'];
    this.content = data['content'];
    this.postDate = data['postDate'];
    this.action = EnumConverter.stringToNotificationAction(data['action']);
  }
  Map<String, dynamic> toJson() {
    return {
      'imageUrl': this.imageUrl,
      'courseId': this.courseId,
      'content': this.content,
      'postDate': this.postDate,
      'action': EnumConverter.notificationActionToString(this.action),
      'receivers': this.receivers,
    };
  }
}

enum NotificationAction {
  openCourse,
  openMyRequest,
  openTheirRequest,
  openChatting,
}
