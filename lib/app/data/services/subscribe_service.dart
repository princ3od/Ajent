import 'package:firebase_messaging/firebase_messaging.dart';

class SubscribeService {
  SubscribeService._privateConstructor();
  static final SubscribeService instance =
      SubscribeService._privateConstructor();

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  subcribeOnAddCourse(String courseId) async {
    await firebaseMessaging.subscribeToTopic('$courseId-public');
    await firebaseMessaging.subscribeToTopic('$courseId-request');
  }

  subcribeOnJoinCourse(String courseId) async {
    await firebaseMessaging.subscribeToTopic('$courseId-public');
  }

  unsubscribeOnLeaveCourse(String courseId) async {
    await firebaseMessaging.unsubscribeFromTopic('$courseId-public');
  }

  subcribeOnRequestCourse(String courseId, String requestId) async {
    await firebaseMessaging.subscribeToTopic('$courseId-request-$requestId');
  }

  subscribeOnLogin(String userUid) async {
    await firebaseMessaging.subscribeToTopic('$userUid');
  }

  unsubscribeOnLogout(String userUid) async {
    await firebaseMessaging.unsubscribeFromTopic('$userUid');
  }

  unsubscribeOnCanelRequest(String courseId, String requestId) async {
    await firebaseMessaging
        .unsubscribeFromTopic('$courseId-request-$requestId');
  }
}
