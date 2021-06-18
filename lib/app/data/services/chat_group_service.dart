import 'package:ajent/app/data/services/collection_interface.dart';
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
    await database.collection(collectionName).doc().set(
          chatGroup.toJson(),
          SetOptions(merge: true),
        );
    return chatGroup;
  }

  Future<List<ChatGroup>> getChatGroups(String uid) async {
    List<ChatGroup> chatGroups = [];
    await database
        .collection(collectionName)
        .where('people', arrayContains: uid)
        .get()
        .then((value) {
      for (var item in value.docs) {
        chatGroups.add(ChatGroup.fromJson(item.id, item.data()));
      }
    });
    return chatGroups;
  }
}
