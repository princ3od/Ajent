import 'package:ajent/app/data/services/collection_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ajent/app/data/models/message.dart';

class MessageService implements CollectionInterface {
  MessageService._privateConstructor();
  static final MessageService instance = MessageService._privateConstructor();

  @override
  String collectionName = 'messages';

  final FirebaseFirestore database = FirebaseFirestore.instance;

  Future<Message> sendMessage(Message message) async {
    DocumentReference groupChatRef =
        database.collection('chat_groups').doc(message.groupID);
    await groupChatRef.collection(collectionName).doc().set(
          message.toJson(),
          SetOptions(merge: true),
        );
    return message;
  }
}
