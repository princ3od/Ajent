import 'dart:async';

import 'package:ajent/app/data/services/collection_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ajent/app/data/models/message.dart';

class MessageService implements CollectionInterface {
  MessageService._privateConstructor();
  static final MessageService instance = MessageService._privateConstructor();

  @override
  String collectionName = 'messages';

  String chatGroupCollection = 'chat_groups';

  final FirebaseFirestore database = FirebaseFirestore.instance;

  Future<Message> sendMessage(Message message) async {
    DocumentReference groupChatRef =
        database.collection(chatGroupCollection).doc(message.groupID);
    await groupChatRef.collection(collectionName).doc().set(
          message.toJson(),
          SetOptions(merge: true),
        );
    return message;
  }

  Future<List<Message>> getMessages(String chatGroupID) async {
    DocumentReference groupChatRef =
        database.collection(chatGroupCollection).doc(chatGroupID);
    List<Message> messages = [];
    await groupChatRef
        .collection(collectionName)
        .orderBy('timeStamp', descending: true)
        .get()
        .then((value) {
      for (var item in value.docs) {
        Message message = Message.fromJson(item.id, item.data());
        messages.add(message);
      }
    });
    return messages;
  }

  Future<Message> getLastMessage(String chatGroupID) async {
    DocumentReference groupChatRef =
        database.collection(chatGroupCollection).doc(chatGroupID);
    Message message;
    await groupChatRef
        .collection(collectionName)
        .orderBy('timeStamp', descending: true)
        .get()
        .then((value) {
      if (value.docs.length > 0)
        message =
            Message.fromJson(value.docs.first.id, value.docs.first.data());
      else
        message = null;
    });
    return message;
  }

  StreamSubscription<QuerySnapshot> subcribeListenMessage(String chatGroupID,
      Function(QuerySnapshot<Map<String, dynamic>> data) onData) {
    DocumentReference groupChatRef =
        database.collection(chatGroupCollection).doc(chatGroupID);
    return groupChatRef.collection(collectionName).snapshots().listen(onData);
  }
}
