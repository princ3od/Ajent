import 'dart:convert';

import 'package:ajent/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NotificationService {
  static final Client client = Client();

  // from 'https://console.firebase.google.com'
  // --> project settings --> cloud messaging --> "Server key"
  static const String serverKey =
      'AAAA2KfeVtQ:APA91bHaLAeRw6vYkdSMuuXiLvbWdx0nAwWlYjTeljDi-sBSZbJjM_iwDouVsGC5lFtwJht6Bwzhe3z8C5hizNy_-yEyBlJJBaDYe4AmsIcA88AO6T0xK8jKcvw2Kuzvc-uAlM3uF4FZ';
  static Future<Response> sendToAll({
    @required String title,
    @required String body,
  }) =>
      sendToTopic(title: title, body: body, topic: 'all');

  static Future<Response> sendToTopic(
          {@required String title,
          @required String body,
          @required String topic}) =>
      sendTo(title: title, body: body, fcmToken: '/topics/$topic');

  static Future<Response> sendTo({
    @required String title,
    @required String body,
    @required String fcmToken,
  }) =>
      client.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: json.encode({
          'notification': {
            'body': '$body',
            'title': '$title',
            'icon': 'ic_stat_ajent',
            'color': '#e74b32',
          },
          'priority': 'high',
          'data': {
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'course': 'abc',
          },
          'to': '$fcmToken',
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
      );
}
