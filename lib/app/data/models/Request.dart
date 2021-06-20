class Request {
  String id;
  String requestorUid;
  String requestorName;
  RequestStatus status;
  RequestType requestType;
}

enum RequestStatus {
  accepted,
  waiting,
  denied,
  canceled,
}
enum RequestType {
  requestToJoin,
  requestToTeach,
}
