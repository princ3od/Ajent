import 'message.dart';

class ChatGroup {
  List<String> people = [];
  String id = "";
  String name;
  Message lastMessage;
  bool seen = true;
  ChatGroup();
  ChatGroup.withParam(this.id, this.people);
  ChatGroup.fromJson(this.id, Map<String, dynamic> data) {
    this.people = data['people'];
    this.id = id;
  }
  Map<String, dynamic> toJson() {
    return {
      'people': this.people,
    };
  }
}
