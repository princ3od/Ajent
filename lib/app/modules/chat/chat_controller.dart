import 'dart:async';
import 'dart:io';

import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/models/chat_group.dart';
import 'package:ajent/app/data/models/message.dart';
import 'package:ajent/app/data/services/chat_group_service.dart';
import 'package:ajent/app/data/services/message_service.dart';
import 'package:ajent/app/data/services/notification_service.dart';
import 'package:ajent/app/data/services/storage_service.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ajent/core/utils/file_utils.dart';

class ChatController extends GetxController {
  AjentUser user = HomeController.mainUser;
  AjentUser partner;
  ChatGroup chatGroup;
  TextEditingController txtContent = TextEditingController();
  bool firstFetch = false;
  var messages = <Message>[].obs;

  var isNewUser = false.obs;
  var isLoading = false.obs;

  StreamSubscription<QuerySnapshot> _listenNewMessage;
  StreamSubscription<QuerySnapshot> _listenChatGroup;

  ChatController(this.partner);

  listenNewMessage() async {
    _listenNewMessage =
        MessageService.instance.subcribeListenMessage(chatGroup.id, (data) {
      for (var item in data.docChanges) {
        if (firstFetch) return;
        Message message = Message.fromJson(item.doc.id, item.doc.data());
        messages.insert(0, message);
      }
    });
  }

  listenChatGroup() async {
    _listenChatGroup = ChatGroupService.instance.subcribeNewChatGroup(
      (data) {
        for (var item in data.docChanges) {
          if (item.doc.data()['people']?.contains([user.uid, partner.uid]) ??
              false) getChatGroup(reload: false);
        }
        return;
      },
    );
  }

  @override
  void onInit() async {
    super.onInit();
    await getChatGroup();
  }

  getChatGroup({bool reload = true}) async {
    if (reload)
      isLoading.value = true;
    else
      _listenChatGroup.cancel();
    chatGroup =
        await ChatGroupService.instance.getChatGroup(user.uid, partner.uid);
    if (chatGroup == null) {
      isNewUser.value = true;
      listenChatGroup();
    } else {
      await fetchMessages();
    }
    if (reload) isLoading.value = false;
  }

  fetchMessages() async {
    listenNewMessage();
    messages.value = await MessageService.instance.getMessages(chatGroup.id);
    firstFetch = false;
  }

  sendTextMessage() async {
    if (txtContent.text.isEmpty) return;
    if (chatGroup == null) {
      chatGroup = ChatGroup()..people = [user.uid, partner.uid];
      chatGroup = await ChatGroupService.instance.createChatGroup(chatGroup);
      if (chatGroup == null) {
        return;
      }
      isNewUser.value = false;
      listenNewMessage();
    }
    Message message = Message()
      ..content = txtContent.text
      ..groupID = chatGroup.id
      ..senderUid = user.uid
      ..timeStamp = DateTime.now().millisecondsSinceEpoch
      ..type = MessageType.text;
    message = await MessageService.instance.sendMessage(message);
    txtContent.clear();
    if (message != null) {
      var rp = await NotificationService.instance
          .notifyNewMessage(user, message.content, partner.uid);
      print(rp.statusCode);
    }
  }

  sendImage() async {
    File image = await FileUtilitiy.getImage();

    if (image == null) return;

    try {
      if (chatGroup == null) {
        chatGroup = ChatGroup()..people = [user.uid, partner.uid];
        chatGroup = await ChatGroupService.instance.createChatGroup(chatGroup);
        if (chatGroup == null) {
          return;
        }
        isNewUser.value = false;
        listenNewMessage();
      }
      String imageUrl = await StorageService.instance.uploadMessageImage(image);
      Message message = Message()
        ..content = imageUrl
        ..groupID = chatGroup.id
        ..senderUid = user.uid
        ..timeStamp = DateTime.now().millisecondsSinceEpoch
        ..type = MessageType.image;
      message = await MessageService.instance.sendMessage(message);
      if (message != null) {
        await NotificationService.instance.notifyNewMessage(
            user, "${user.name} send you an image", partner.uid);
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<Message> sendInvitation(
      String courseId, String partnerUid) async {
    ChatGroup chatGroup = await ChatGroupService.instance
        .getChatGroup(HomeController.mainUser.uid, partnerUid);
    if (chatGroup == null) {
      chatGroup = ChatGroup()
        ..people = [HomeController.mainUser.uid, partnerUid];
      chatGroup = await ChatGroupService.instance.createChatGroup(chatGroup);
      if (chatGroup == null) {
        return null;
      }
    }
    Message message = Message()
      ..content = courseId
      ..groupID = chatGroup.id
      ..senderUid = HomeController.mainUser.uid
      ..timeStamp = DateTime.now().millisecondsSinceEpoch
      ..type = MessageType.invitation;
    message = await MessageService.instance.sendMessage(message);
    if (message != null) {
      await NotificationService.instance.notifyNewMessage(
          HomeController.mainUser,
          "${HomeController.mainUser.name} send you a course",
          partnerUid);
    }
    return message;
  }

  bool needShowTime(int index) {
    if (index == messages.length - 1) return true;
    final time = DateTime.fromMillisecondsSinceEpoch(messages[index].timeStamp)
        .toLocal();
    final lastTime =
        DateTime.fromMillisecondsSinceEpoch(messages[index + 1].timeStamp)
            .toLocal();
    if (time.difference(lastTime).inMinutes > 5) return true;
    return false;
  }

  bool isLastLeft(int index) {
    if ((index > 0 &&
            messages != null &&
            messages[index - 1].senderUid == user.uid) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void onClose() async {
    super.onClose();
    if (chatGroup == null) {
      await _listenChatGroup.cancel();
    } else
      await _listenNewMessage.cancel();
  }
}
