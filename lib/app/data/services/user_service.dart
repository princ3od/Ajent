import 'package:ajent/app/data/models/Degree.dart';
import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/services/collection_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ajent/app/data/models/Student.dart';
import 'package:flutter/material.dart';
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

  Future<bool> updateInfo(AjentUser ajentUser) async {
    bool success = false;
    await database
        .collection(collectionName)
        .doc(ajentUser.uid)
        .set(ajentUser.toJson())
        .whenComplete(() {
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
        print('${element.id}');
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

  Future<List<Student>> getStudents(String uid) async {
    List<Student> students = [];
    await database
        .collection(collectionName)
        .doc(uid)
        .collection('students')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print('${element.id}');
        Student student =
            Student.fromJson(id: element.id, data: element.data());
        students.add(student);
      });
    }).catchError((error) => print(error));
    return students;
  }

  Future<bool> delStudent(String uid, String studentId) async {
    bool success = false;
    await database
        .collection(collectionName)
        .doc(uid)
        .collection('students')
        .doc(studentId)
        .delete()
        .then((value) {
      print('Student $studentId Have Been Deleted');
      success = true;
    }).catchError((error) => print('$error'));
    return success;
  }

  Future<bool> updateUserAvatar(AjentUser ajentUser, File fileAvatar) async {
    try {
      StorageService storeInstance = StorageService.instance;
      String avatarUrl =
          await storeInstance.uploadImage(fileAvatar, ajentUser.uid);
      ajentUser.avatarUrl = avatarUrl;
      await this.updateInfo(ajentUser);
      return true;
    } catch (exception) {
      print('$exception');
      return false;
    }
  }

  Future<bool> addStudent(String uid, Student student) async {
    bool success = false;
    try {
      await database
          .collection(collectionName)
          .doc(uid)
          .collection('students')
          .add(student.toJson())
          .then((value) {
        print('$value' + ' student data have been added');
        success = true;
      }).catchError((error) {
        print('$error');
        success = false;
      });
    } catch (exception) {
      return false;
    }
    return success;
  }
}
