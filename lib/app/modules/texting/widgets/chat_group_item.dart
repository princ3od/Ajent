import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/global_widgets/user_avatar.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/app/modules/texting/texting_controller.dart';
import 'package:ajent/core/utils/date_converter.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:ajent/app/data/models/chat_group.dart';
import 'package:ajent/app/data/models/message.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatGroupItem extends StatelessWidget {
  final ChatGroup chatGroup;
  final int index;
  ChatGroupItem({@required this.chatGroup, @required this.index});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        dense: true,
        title: Text(
          chatGroup.partner.name,
          style: GoogleFonts.nunitoSans(
              fontSize: 16,
              fontWeight: (chatGroup.seen) ? FontWeight.w600 : FontWeight.bold),
        ),
        subtitle: (chatGroup.lastMessage == null)
            ? Container()
            : lastMessage(chatGroup.lastMessage),
        leading: UserAvatar(user: chatGroup.partner, size: 24),
        trailing: AnimatedOpacity(
            opacity: (chatGroup.seen) ? 0 : 1,
            duration: Duration(milliseconds: 180),
            child: Icon(Icons.circle, color: primaryColor, size: 8)),
      ),
      onTap: () {
        Get.find<TextingController>().chatGroups[index].seen = true;
        Get.find<TextingController>().chatGroups.refresh();
        FocusManager.instance.primaryFocus.unfocus();
        Get.toNamed(Routes.CHATTING, arguments: chatGroup.partner);
      },
    );
  }

  Widget lastMessage(Message message) {
    String txt = "";

    if (message.type == MessageType.text) {
      if (message.senderUid == HomeController.mainUser.uid) {
        txt += "You: ".tr;
      }
      txt += message.content;
    } else if (message.type == MessageType.image) {
      if (message.senderUid == HomeController.mainUser.uid) {
        txt += "You sent an image".tr;
      } else
        txt += "${chatGroup.partner.name} " + "sent an image".tr;
    } else {
      if (message.senderUid == HomeController.mainUser.uid) {
        txt += "You sent a course".tr;
      } else
        txt += "${chatGroup.partner.name} " + "sent a course".tr;
    }
    return Row(
      children: [
        Flexible(
          flex: 4,
          child: Text(
            txt,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.nunitoSans(
              fontSize: 12,
              fontWeight: (chatGroup.seen) ? FontWeight.w600 : FontWeight.bold,
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Text(
            " - " + DateConverter.getTime(message.timeStamp, true),
            overflow: TextOverflow.clip,
            style: GoogleFonts.nunitoSans(
              fontSize: 12,
              fontWeight: (chatGroup.seen) ? FontWeight.w600 : FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
