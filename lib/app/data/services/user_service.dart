import 'package:ajent/app/data/models/Degree.dart';
import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/services/collection_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'storage_service.dart';

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

  Future<bool> updateInfo(AjentUser ajentUser) async {
    bool success = false;
    await database
        .collection(collectionName)
        .doc(ajentUser.uid)
        .set(ajentUser.toJson(), SetOptions(merge: true))
        .whenComplete(() {
      success = true;
    }).catchError((error) => print('Occured error $error'));
    return success;
  }

  Future<bool> updateSubsciption(AjentUser ajentUser) async {
    bool success = false;
    await database.collection(collectionName).doc(ajentUser.uid).set({
      'topics': ajentUser.topics,
    }, SetOptions(merge: true)).whenComplete(() {
      success = true;
    }).catchError((error) => print('Occured error $error'));
    return success;
  }

  Future<List<Degree>> getDegrees(String uid) async {
    List<Degree> degrees = [];
    await database
        .collection(collectionName)
        .doc(uid)
        .collection('degrees')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        Degree item = Degree.fromJson(id: element.id, data: element.data());
        degrees.add(item);
      });
    }).catchError(
            (error) => print("Failed to get user degrees property: $error"));
    return degrees;
  }

  Future<bool> delDegree(String uid, String docId) async {
    try {
      await database
          .collection(collectionName)
          .doc(uid)
          .collection('degrees')
          .doc(docId)
          .delete()
          .then((value) => print('Degree $docId Have Been Deleted'))
          .catchError((error) {
        print("Failed to delete user's property: $error");
        return false;
      });
      return true;
    } catch (exception) {
      print('${exception.toString()}');
      return false;
    }
  }

  Future<bool> addDegree(String uid, Degree newDegree) async {
    bool success = false;
    await database
        .collection(collectionName)
        .doc(uid)
        .collection('degrees')
        .add(newDegree.toJson())
        .then((value) {
      success = true;
      print("Degree Added..");
    }).catchError((onError) {
      success = false;
      print("Failed to add user: $onError");
    });
    return success;
  }

  Future<String> updateUserAvatar(AjentUser ajentUser, File fileAvatar) async {
    String avatarUrl;
    try {
      StorageService storeInstance = StorageService.instance;
      avatarUrl = await storeInstance.uploadImage(fileAvatar, ajentUser.uid);
      ajentUser.avatarUrl = avatarUrl;
      await this.updateInfo(ajentUser);
    } catch (exception) {
      print('$exception');
      return null;
    }
    return avatarUrl;
  }

  Future<double> getAverageEvaluationStar(String userUid) async {
    int totalEvaluation = 0;
    double totalStar = 0.0;
    await database
        .collection('courses')
        .where('teacher', isEqualTo: userUid)
        .get()
        .then((value) {
      for (var element in value.docs) {
        double star = element.data()['evaluationStar'] * 1.0;
        if (star < 0) {
          continue;
        }
        totalStar += star;
        totalEvaluation++;
      }
    });
    if (totalEvaluation == 0) return -1.0;
    return (totalStar / totalEvaluation);
  }

  Stream<QuerySnapshot> searchUser({String keyword}) {
    return database
        .collection(collectionName)
        .where('indexList', arrayContains: keyword)
        .orderBy('name')
        .snapshots();
  }
}
