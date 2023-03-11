import 'dart:convert';

import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/models/notification_model.dart';
import 'package:ajent/app/data/services/collection_interface.dart';
import 'package:ajent/app/data/services/course_service.dart';
import 'package:ajent/core/utils/enum_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ajent/app/data/models/Request.dart' as AjentRequest;
import 'package:http/http.dart';

class NotificationService implements CollectionInterface {
  NotificationService._privateConstructor();
  static final NotificationService instance =
      NotificationService._privateConstructor();
  final FirebaseFirestore database = FirebaseFirestore.instance;
  final Client _client = Client();

  final String _serverKey =
      'AAAA2KfeVtQ:APA91bHaLAeRw6vYkdSMuuXiLvbWdx0nAwWlYjTeljDi-sBSZbJjM_iwDouVsGC5lFtwJht6Bwzhe3z8C5hizNy_-yEyBlJJBaDYe4AmsIcA88AO6T0xK8jKcvw2Kuzvc-uAlM3uF4FZ';

  onNotificationOpenApp(Function(RemoteMessage) func) {
    FirebaseMessaging.onMessageOpenedApp.listen(func);
  }

  onNotication(Function(RemoteMessage) func) {
    FirebaseMessaging.onMessage.listen(func);
  }

  Future<RemoteMessage> getInitialNotification() async {
    return await FirebaseMessaging.instance.getInitialMessage();
  }

  Future<NotificationModel> storeNotication(
      NotificationModel notificationModel) async {
    DocumentReference documentReference = await database
        .collection(collectionName)
        .add(notificationModel.toJson());
    notificationModel.id = documentReference.id;
    return notificationModel;
  }

  Future<String> deleteNotification(String notificationId) async {
    await database
        .collection(collectionName)
        .doc(notificationId)
        .delete()
        .catchError((error) {
      notificationId = null;
    });
    return notificationId;
  }

  Future<List<NotificationModel>> getAllNotifications(String user) async {
    List<NotificationModel> notifications = [];
    await database
        .collection(collectionName)
        .where('receivers', arrayContains: user)
        .get()
        .then((value) {
      for (var item in value.docs) {
        NotificationModel notificationModel =
            NotificationModel.fromJson(item.id, item.data());
        notifications.add(notificationModel);
      }
    });
    notifications.sort((a, b) => b.postDate.compareTo(a.postDate));
    return notifications;
  }

  Future<Response> notifyJoinCourse(Course course, AjentUser joiner) async {
    String _body = "${joiner.name} Just took the course ${course.name}.";
    Map<String, dynamic> _data = {
      'action': 'openCourse',
      'courseId': '${course.id}',
    };
    NotificationModel data = NotificationModel()
      ..action = NotificationAction.openCourse
      ..content = _body
      ..receivers = List.from(course.learners)
      ..courseId = course.id
      ..postDate = DateTime.now().millisecondsSinceEpoch
      ..imageUrl = joiner.avatarUrl;
    if (course.hasTeacher()) {
      data.receivers.add(course.teacher);
    }
    data.receivers.remove(joiner.uid);
    await storeNotication(data);
    return await _sendToTopic(
        title: "Tutor Time",
        body: _body,
        topic: "${course.id}-public",
        image: course.photoUrl,
        data: _data);
  }

  Future<Response> notifyLeaveCourse(Course course, AjentUser joiner) async {
    String _body = "${joiner.name} just left the course ${course.name}.";
    Map<String, dynamic> _data = {
      'action': 'openCourse',
      'courseId': '${course.id}',
    };
    NotificationModel data = NotificationModel()
      ..action = NotificationAction.openCourse
      ..content = _body
      ..receivers = List.from(course.learners)
      ..courseId = course.id
      ..postDate = DateTime.now().millisecondsSinceEpoch
      ..imageUrl = joiner.avatarUrl;
    if (course.hasTeacher()) {
      data.receivers.add(course.teacher);
    }
    data.receivers.remove(joiner.uid);
    await storeNotication(data);
    return await _sendToTopic(
        title: "Tutor Time",
        body: _body,
        topic: "${course.id}-public",
        image: course.photoUrl,
        data: _data);
  }

  Future<Response> notifyRequestCourse(
      Course course, AjentUser requestor) async {
    String _body =
        "${requestor.name} Just applied to become a lecturer of the course ${course.name}.";
    Map<String, dynamic> _data = {
      'action': 'openTheirRequest',
      'courseId': '${course.id}',
    };
    NotificationModel data = NotificationModel()
      ..action = NotificationAction.openTheirRequest
      ..content = _body
      ..receivers = [course.owner]
      ..courseId = course.id
      ..postDate = DateTime.now().millisecondsSinceEpoch
      ..imageUrl = requestor.avatarUrl;
    data.receivers.remove(requestor.uid);
    await storeNotication(data);
    return await _sendToTopic(
        title: "Tutor Time",
        body: _body,
        topic: "${course.id}-request",
        image: requestor.avatarUrl,
        data: _data);
  }

  Future<Response> notifyApproveCourse(
      Course course, AjentRequest.Request request) async {
    String _body =
        "Congratulations! You have just become a teacher of the course ${course.name}. 🥳";
    Map<String, dynamic> _data = {
      'action': 'openCourse',
      'courseId': '${course.id}',
    };
    NotificationModel data = NotificationModel()
      ..action = NotificationAction.openCourse
      ..content = _body
      ..receivers = [request.requestorUid]
      ..courseId = course.id
      ..postDate = DateTime.now().millisecondsSinceEpoch
      ..imageUrl = course.photoUrl;
    await storeNotication(data);
    await _sendToTopic(
        title: "Tutor Time",
        body: _body,
        topic: "${course.id}-request-${request.id}",
        image: course.photoUrl,
        data: _data);
    _body = "Courses ${course.name} already have a teacher.";
    data = NotificationModel()
      ..action = NotificationAction.openCourse
      ..content = _body
      ..receivers = course.learners
      ..courseId = course.id
      ..postDate = DateTime.now().millisecondsSinceEpoch
      ..imageUrl = course.photoUrl;
    await storeNotication(data);
    return _sendToTopic(
        title: "Tutor Time",
        body: _body,
        topic: "${course.id}-public",
        image: course.photoUrl,
        data: _data);
  }

  Future<Response> notifyDenyRequest(
      Course course, AjentRequest.Request request) async {
    String _body =
        "Requirements to apply to teach the course ${course.name} Yours has been rejected. 😥";
    Map<String, dynamic> _data = {
      'action': 'openMyRequest',
      'courseId': '${course.id}',
    };
    NotificationModel data = NotificationModel()
      ..action = NotificationAction.openMyRequest
      ..content = _body
      ..receivers = [request.requestorUid]
      ..courseId = course.id
      ..postDate = DateTime.now().millisecondsSinceEpoch
      ..imageUrl = course.photoUrl;
    await storeNotication(data);
    return await _sendToTopic(
        title: "Tutor Time",
        body: _body,
        topic: "${course.id}-request-${request.id}",
        image: course.photoUrl,
        data: _data);
  }

  Future<Response> notifyCancelRequest(
      Course course, AjentUser requestor) async {
    String _body =
        "${requestor.name} Canceled the application to teach the course ${course.name}.";
    Map<String, dynamic> _data = {
      'action': 'openTheirRequest',
      'courseId': '${course.id}',
    };
    return await _sendToTopic(
        title: "Tutor Time",
        body: _body,
        topic: "${course.id}-request",
        image: requestor.avatarUrl,
        data: _data);
  }

  Future<Response> notifyNewMessage(
      AjentUser from, String content, String toUid) {
    String _body = "$content";
    Map<String, dynamic> _data = {
      'action': 'openChatting',
      'partner': '${from.uid}',
    };
    return _sendToTopic(
        title: "${from.name}",
        body: _body,
        topic: "$toUid",
        image: "${from.avatarUrl}",
        data: _data);
  }

  Future<Response> _sendToTopic({
    @required String title,
    @required String body,
    @required String topic,
    @required String image,
    @required Map<String, dynamic> data,
  }) {
    data['click_action'] = 'FLUTTER_NOTIFICATION_CLICK';
    return _sendTo(
        title: title,
        body: body,
        fcmToken: '/topics/$topic',
        data: data,
        image: image);
  }

  Future<Response> _sendTo({
    @required String title,
    @required String body,
    @required String fcmToken,
    @required String image,
    @required Map<String, dynamic> data,
  }) =>
      _client.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: json.encode({
          'notification': {
            'body': '$body',
            'title': '$title',
            'icon': 'ic_stat_ajent',
            'color': '#619FCD',
          },
          'priority': 'high',
          'data': data,
          'to': '$fcmToken',
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$_serverKey',
        },
      );

  @override
  String collectionName = 'notifications';
  // Future<Response> _sendToAll({
  //   @required String title,
  //   @required String body,
  // }) =>
  //     _sendToTopic(title: title, body: body, topic: 'all');
}
