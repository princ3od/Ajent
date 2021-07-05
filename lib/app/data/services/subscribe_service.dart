import 'package:ajent/app/data/services/user_service.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SubscribeService {
  SubscribeService._privateConstructor();
  static final SubscribeService instance =
      SubscribeService._privateConstructor();

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  subcribeOnAddCourse(String courseId) async {
    await firebaseMessaging.subscribeToTopic('$courseId-public');
    await firebaseMessaging.subscribeToTopic('$courseId-request');
    if (!HomeController.mainUser.topics.contains('$courseId-public'))
      HomeController.mainUser.topics.add('$courseId-public');
    if (!HomeController.mainUser.topics.contains('$courseId-request'))
      HomeController.mainUser.topics.add('$courseId-request');
    await UserService.instance.updateSubsciption(HomeController.mainUser);
  }

  subcribeOnJoinCourse(String courseId) async {
    await firebaseMessaging.subscribeToTopic('$courseId-public');
    if (!HomeController.mainUser.topics.contains('$courseId-public'))
      HomeController.mainUser.topics.add('$courseId-public');
    await UserService.instance.updateSubsciption(HomeController.mainUser);
  }

  unsubscribeOnLeaveCourse(String courseId) async {
    await firebaseMessaging.unsubscribeFromTopic('$courseId-public');
    if (HomeController.mainUser.topics.contains('$courseId-public'))
      HomeController.mainUser.topics.remove('$courseId-public');
    await UserService.instance.updateSubsciption(HomeController.mainUser);
  }

  subcribeOnRequestCourse(String courseId, String requestId) async {
    await firebaseMessaging.subscribeToTopic('$courseId-request-$requestId');
    if (!HomeController.mainUser.topics
        .contains('$courseId-request-$requestId'))
      HomeController.mainUser.topics.add('$courseId-request-$requestId');
    await UserService.instance.updateSubsciption(HomeController.mainUser);
  }

  subscribeOnLogin(String userUid) async {
    await firebaseMessaging.subscribeToTopic('$userUid');
    if (!HomeController.mainUser.topics.contains('$userUid'))
      HomeController.mainUser.topics.add('$userUid');
    await UserService.instance.updateSubsciption(HomeController.mainUser);
  }

  unsubscribeOnLogout(String userUid) async {
    await firebaseMessaging.unsubscribeFromTopic('$userUid');
  }

  unsubscribeOnCanelRequest(String courseId, String requestId) async {
    await firebaseMessaging
        .unsubscribeFromTopic('$courseId-request-$requestId');
    if (HomeController.mainUser.topics.contains('$courseId-request-$requestId'))
      HomeController.mainUser.topics.remove('$courseId-request-$requestId');
    await UserService.instance.updateSubsciption(HomeController.mainUser);
  }

  subcriceAll() async {
    for (var item in HomeController.mainUser.topics) {
      await firebaseMessaging.subscribeToTopic(item);
    }
  }

  unsubcriceAll() async {
    for (var item in HomeController.mainUser.topics) {
      await firebaseMessaging.unsubscribeFromTopic(item);
    }
  }
}
