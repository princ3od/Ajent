import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/services/collection_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService implements CollectionInterface {
  UserService._privateConstructor();
  static final UserService instance = UserService._privateConstructor();

  final FirebaseFirestore database = FirebaseFirestore.instance;

  @override
  String collectionName = 'users';
  Future<bool> isUserExisted(User user) async {
    DocumentSnapshot docs = await database
        .collection(collectionName)
        .doc(user.uid.toString())
        .get();
    return docs.exists;
  }

  Future<AjentUser> addUser(AjentUser ajentUser, [String fbToken = ""]) async {
    await database.collection(collectionName).doc(ajentUser.uid).set(
          ajentUser.toJson(),
          SetOptions(merge: true),
        );
    return ajentUser;
  }

  Future<AjentUser> getUser(String uid) async {
    AjentUser ajentUser;
    await database
        .collection(collectionName)
        .doc(uid)
        .get()
        .then((value) => ajentUser = AjentUser.fromJson(uid, value.data()));
    return ajentUser;
  }
}
