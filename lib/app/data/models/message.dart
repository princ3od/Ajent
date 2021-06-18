import 'package:ajent/core/utils/enum_converter.dart';

class Message {
  String id;
  String senderUid;
  String content;
  int timeStamp;
  String groupID;
  MessageType type;
  Message();
  Message.withParam(
      this.senderUid, this.groupID, this.content, this.timeStamp, this.type);
  Message.fromJson(String id, Map<String, dynamic> data) {
    this.id = id;
    this.senderUid = data['senderUid'];
    this.content = data['content'];
    this.timeStamp = data['timeStamp'];
    this.type = EnumConverter.stringToMessageType(data['type']);
  }
  Map<String, dynamic> toJson() {
    return {
      'senderUid': this.senderUid,
      'content': this.content,
      'timeStamp': this.timeStamp,
      'type': EnumConverter.messageTypeToString(this.type),
    };
  }
}

enum MessageType {
  text,
  image,
  invitation,
}
