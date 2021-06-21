import 'package:ajent/app/data/models/ajent_user.dart';

import 'message.dart';

class ChatGroup {
  List<String> people = [];
  String id = "";
  String name;
  String photoUrl;
  Message lastMessage;
  AjentUser partner;
  bool seen = true;
  ChatGroup();
  ChatGroup.withParam(this.id, this.people);
  ChatGroup.fromJson(this.id, Map<String, dynamic> data) {
    this.people = List.from(data['people']);
    this.id = id;
  }
  Map<String, dynamic> toJson() {
    return {
      'people': this.people,
    };
  }
}
