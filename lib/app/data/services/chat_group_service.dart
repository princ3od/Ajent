import 'dart:async';

import 'package:ajent/app/data/services/collection_interface.dart';
import 'package:ajent/app/data/services/message_service.dart';
import 'package:ajent/app/data/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ajent/app/data/models/chat_group.dart';

class ChatGroupService implements CollectionInterface {
  ChatGroupService._privateConstructor();
  static final ChatGroupService instance =
      ChatGroupService._privateConstructor();

  @override
  String collectionName = 'chat_groups';

  final FirebaseFirestore database = FirebaseFirestore.instance;

  Future<ChatGroup> createChatGroup(ChatGroup chatGroup) async {
    DocumentReference chatGroupRef =
        await database.collection(collectionName).add(chatGroup.toJson());
    chatGroup.id = chatGroupRef.id;
    return chatGroup;
  }

  Future<List<ChatGroup>> getChatGroups(String user) async {
    List<ChatGroup> chatGroups = [];
    await database
        .collection(collectionName)
        .where('people', arrayContains: user)
        .get()
        .then((value) async {
      for (var item in value.docs) {
        ChatGroup chatGroup = ChatGroup.fromJson(item.id, item.data());
        if (chatGroup.people[0] != user) {
          chatGroup.partner =
              await UserService.instance.getUser(chatGroup.people[0]);
        } else {
          chatGroup.partner =
              await UserService.instance.getUser(chatGroup.people[1]);
        }
        chatGroup.lastMessage =
            await MessageService.instance.getLastMessage(chatGroup.id);
        chatGroups.add(chatGroup);
      }
    });
    return chatGroups;
  }

  Future<ChatGroup> getChatGroup(String user, String partner) async {
    ChatGroup chatGroup;
    QuerySnapshot querySnapshot = await database
        .collection(collectionName)
        .where('people', arrayContains: user)
        .get();
    if (querySnapshot.docs.isEmpty) return null;
    List<ChatGroup> chatGroups = await getChatGroups(user);
    for (var item in chatGroups) {
      if (item.partner.uid == partner) {
        chatGroup = item;
        break;
      }
    }
    return chatGroup;
  }

  StreamSubscription<QuerySnapshot> subcribeNewChatGroup(
      Function(QuerySnapshot<Map<String, dynamic>> data) onData) {
    return database.collection(collectionName).snapshots().listen(onData);
  }
}
