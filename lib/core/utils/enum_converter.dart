import 'package:ajent/app/data/models/Request.dart';
import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/models/message.dart';
import 'package:ajent/app/data/models/Person.dart';
import 'package:ajent/app/data/models/notification_model.dart';

class EnumConverter {
  static String genderToString(Gender gender) {
    switch (gender) {
      case Gender.male:
        return "male";
      case Gender.female:
        return "female";
      default:
        return "";
    }
  }

  static Gender stringToGender(String data) {
    switch (data) {
      case "male":
        return Gender.male;
      case "female":
        return Gender.female;
      default:
        return Gender.male;
    }
  }

  static String timeTypeToString(TimeType timeType) {
    switch (timeType) {
      case TimeType.periodTime:
        return "periodTime";
      case TimeType.fixedTime:
        return "fixedTime";
      default:
        return "";
    }
  }

  static TimeType stringToTimeType(String data) {
    switch (data) {
      case "periodTime":
        return TimeType.periodTime;
      case "fixedTime":
        return TimeType.fixedTime;
      default:
        return TimeType.fixedTime;
    }
  }

  static String messageTypeToString(MessageType messageType) {
    switch (messageType) {
      case MessageType.text:
        return "text";
      case MessageType.image:
        return "image";
      case MessageType.invitation:
        return "invitation";
      default:
        return "text";
    }
  }

  static MessageType stringToMessageType(String data) {
    switch (data) {
      case "text":
        return MessageType.text;
      case "image":
        return MessageType.image;
      case "invitation":
        return MessageType.invitation;
      default:
        return MessageType.text;
    }
  }

  static String requestStatusToString(RequestStatus requestStatus) {
    switch (requestStatus) {
      case RequestStatus.accepted:
        return "accepted";
      case RequestStatus.waiting:
        return "waiting";
      case RequestStatus.denied:
        return "denied";
      case RequestStatus.canceled:
        return "canceled";
      default:
        return "waiting";
    }
  }

  static RequestStatus stringToRequestStatus(String data) {
    switch (data) {
      case "accepted":
        return RequestStatus.accepted;
      case "waiting":
        return RequestStatus.waiting;
      case "denied":
        return RequestStatus.denied;
      case "canceled":
        return RequestStatus.canceled;
      default:
        return RequestStatus.waiting;
    }
  }

  static String notificationActionToString(
      NotificationAction notificationAction) {
    switch (notificationAction) {
      case NotificationAction.openChatting:
        return "openChatting";
      case NotificationAction.openCourse:
        return "openCourse";
      case NotificationAction.openMyRequest:
        return "openMyRequest";
      case NotificationAction.openTheirRequest:
        return "openTheirRequest";
      default:
        return "openCourse";
    }
  }

  static NotificationAction stringToNotificationAction(String data) {
    switch (data) {
      case "openChatting":
        return NotificationAction.openChatting;
      case "openCourse":
        return NotificationAction.openCourse;
      case "openMyRequest":
        return NotificationAction.openMyRequest;
      case "openTheirRequest":
        return NotificationAction.openTheirRequest;
      default:
        return NotificationAction.openCourse;
    }
  }
}
