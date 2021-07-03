import 'dart:convert';

import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:ajent/app/data/models/Request.dart' as AjentRequest;
import 'package:http/http.dart';

class NotificationService {
  NotificationService._privateConstructor();
  static final NotificationService instance =
      NotificationService._privateConstructor();
  final Client _client = Client();

  final String _serverKey =
      'AAAA2KfeVtQ:APA91bHaLAeRw6vYkdSMuuXiLvbWdx0nAwWlYjTeljDi-sBSZbJjM_iwDouVsGC5lFtwJht6Bwzhe3z8C5hizNy_-yEyBlJJBaDYe4AmsIcA88AO6T0xK8jKcvw2Kuzvc-uAlM3uF4FZ';

  Future<Response> notifyJoinCourse(Course course, AjentUser joiner) {
    String _body = "${joiner.name} vừa tham gia khoá học ${course.name}.";
    Map<String, dynamic> _data = {
      'action': 'openCourse',
      'courseId': '${course.id}',
    };
    return _sendToTopic(
        title: "Ajent",
        body: _body,
        topic: "${course.id}-public",
        image: course.photoUrl,
        data: _data);
  }

  Future<Response> notifyLeaveCourse(Course course, AjentUser joiner) {
    String _body = "${joiner.name} vừa rời khỏi khoá học ${course.name}.";
    Map<String, dynamic> _data = {
      'action': 'openCourse',
      'courseId': '${course.id}',
    };
    return _sendToTopic(
        title: "Ajent",
        body: _body,
        topic: "${course.id}-public",
        image: course.photoUrl,
        data: _data);
  }

  Future<Response> notifyRequestCourse(Course course, AjentUser requestor) {
    String _body =
        "${requestor.name} vừa ứng tuyển trờ thành giảng viên của khoá học ${course.name}.";
    Map<String, dynamic> _data = {
      'action': 'openTheirRequest',
      'courseId': '${course.id}',
    };
    return _sendToTopic(
        title: "Ajent",
        body: _body,
        topic: "${course.id}-request",
        image: requestor.avatarUrl,
        data: _data);
  }

  Future<Response> notifyApproveCourse(
      Course course, AjentRequest.Request request) {
    String _body =
        "Chúc mừng! Bạn vừa trờ thành giảng viên của khoá học ${course.name}. 🥳";
    Map<String, dynamic> _data = {
      'action': 'openCourse',
      'courseId': '${course.id}',
    };
    _sendToTopic(
        title: "Ajent",
        body: _body,
        topic: "${course.id}-request-${request.id}",
        image: course.photoUrl,
        data: _data);
    _body = "Khoá học ${course.name} đã có giáo viên.";
    return _sendToTopic(
        title: "Ajent",
        body: _body,
        topic: "${course.id}-public",
        image: course.photoUrl,
        data: _data);
  }

  Future<Response> notifyDenyRequest(
      Course course, AjentRequest.Request request) {
    String _body =
        "Yêu cầu ứng tuyển giảng dạy khoá học ${course.name} của bạn đã bị từ chối. 😥";
    Map<String, dynamic> _data = {
      'action': 'openMyRequest',
      'courseId': '${course.id}',
    };
    return _sendToTopic(
        title: "Ajent",
        body: _body,
        topic: "${course.id}-request-${request.id}",
        image: course.photoUrl,
        data: _data);
  }

  Future<Response> notifyCancelRequest(Course course, AjentUser requestor) {
    String _body =
        "${requestor.name} đã huỷ ứng tuyển giảng dạy khoá học ${course.name}.";
    Map<String, dynamic> _data = {
      'action': 'openTheirRequest',
      'courseId': '${course.id}',
    };
    return _sendToTopic(
        title: "Ajent",
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
            'color': '#e74b32',
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
  // Future<Response> _sendToAll({
  //   @required String title,
  //   @required String body,
  // }) =>
  //     _sendToTopic(title: title, body: body, topic: 'all');
}
