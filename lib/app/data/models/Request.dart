import 'package:ajent/core/utils/enum_converter.dart';

class Request {
  String id;
  String requestorUid;
  String courseId;
  String receiverUid;
  int postDate;
  RequestStatus status;
  Request();
  Request.fromJson(String id, Map<String, dynamic> data) {
    this.id = id;
    requestorUid = data['requestorUid'];
    courseId = data['courseId'];
    receiverUid = data['receiverUid'];
    status = EnumConverter.stringToRequestStatus(data['status']);
    postDate = data['postDate'];
  }

  Map<String, dynamic> toJson() {
    return {
      'requestorUid': requestorUid,
      'courseId': courseId,
      'receiverUid': receiverUid,
      'status': EnumConverter.requestStatusToString(status),
      'postDate': this.postDate
    };
  }
}

enum RequestStatus {
  accepted,
  waiting,
  denied,
  canceled,
}
