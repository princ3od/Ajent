import 'dart:async';

import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/models/message.dart';
import 'package:ajent/app/data/services/chat_group_service.dart';
import 'package:ajent/app/data/services/message_service.dart';
import 'package:ajent/app/data/services/user_service.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:ajent/app/data/models/chat_group.dart';

class TextingController extends GetxController {
  bool firstFetch = true;
  AjentUser user = HomeController.mainUser;

  var isLoadingGroup = false.obs;
  var chatGroups = <ChatGroup>[].obs;

  StreamSubscription<QuerySnapshot> _listenNewChat;
  var _listenLastMessage = <StreamSubscription<QuerySnapshot>>[];
  @override
  void onInit() async {
    super.onInit();
    listenNewChatGroup();
    fetchChatGroup();
  }

  fetchChatGroup() async {
    isLoadingGroup.value = true;
    chatGroups.value = await ChatGroupService.instance.getChatGroups(user.uid);
    chatGroups.sort(
        (a, b) => b.lastMessage.timeStamp.compareTo(a.lastMessage.timeStamp));
    _listenLastMessage = List.filled(chatGroups.length, null, growable: true);
    for (var i = 0; i < chatGroups.length; i++) {
      chatGroups[i].seen = true;
      _listenLastMessage[i] = MessageService.instance
          .subcribeListenMessage(chatGroups[i].id, (data) {
        if (firstFetch && i == chatGroups.length - 1) {
          print(firstFetch);
          firstFetch = false;
          return;
        }
        if (data.docChanges.length > 0) {
          chatGroups[i].lastMessage = Message.fromJson(
              data.docChanges.first.doc.id, data.docChanges.first.doc.data());
          if (chatGroups[i].lastMessage.senderUid != user.uid)
            chatGroups[i].seen = false;
          chatGroups.refresh();
        }
      });
    }
    isLoadingGroup.value = false;
  }

  listenNewChatGroup() {
    _listenNewChat =
        ChatGroupService.instance.subcribeNewChatGroup((data) async {
      if (firstFetch) {
        if (chatGroups.length == 0) firstFetch = false;
        return;
      }
      for (var item in data.docChanges) {
        if (item.doc.data()['people']?.contains(user.uid) ?? false) {
          ChatGroup chatGroup =
              ChatGroup.fromJson(item.doc.id, item.doc.data());
          if (chatGroup.people[0] != user.uid) {
            chatGroup.partner =
                await UserService.instance.getUser(chatGroup.people[0]);
          } else {
            chatGroup.partner =
                await UserService.instance.getUser(chatGroup.people[1]);
          }
          chatGroup.lastMessage =
              await MessageService.instance.getLastMessage(chatGroup.id);
          chatGroups.insert(0, chatGroup);
          _listenLastMessage.add(MessageService.instance
              .subcribeListenMessage(chatGroups[0].id, (data) {
            if (data.docChanges.length > 0) {
              chatGroups[0].lastMessage = Message.fromJson(
                  data.docChanges.first.doc.id,
                  data.docChanges.first.doc.data());
              if (chatGroups[0].lastMessage.senderUid != user.uid)
                chatGroups[0].seen = false;
              chatGroups.refresh();
            }
          }));
        }
      }
    });
  }

  @override
  void onClose() {
    _listenNewChat.cancel();
    for (var item in _listenLastMessage) {
      item.cancel();
    }
    super.onClose();
  }
}
