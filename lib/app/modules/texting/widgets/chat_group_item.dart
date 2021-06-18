import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/global_widgets/user_avatar.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/core/utils/date_converter.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:ajent/app/data/models/chat_group.dart';
import 'package:ajent/app/data/models/message.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatGroupItem extends StatelessWidget {
  final ChatGroup chatGroup;
  final AjentUser partner;
  ChatGroupItem({@required this.chatGroup, @required this.partner});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        dense: true,
        title: Text(
          partner.name,
          style: GoogleFonts.nunitoSans(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: lastMessage(chatGroup.lastMessage),
        leading: UserAvatar(user: partner, size: 40),
        onTap: () {
          Get.toNamed(Routes.CHATTING, arguments: chatGroup);
        },
      ),
    );
  }

  Widget lastMessage(Message message) {
    String txt = "";
    if (message.senderUid == HomeController.mainUser.uid) {
      txt += "You";
    } else {
      txt += partner.name;
    }
    if (message.type == MessageType.text) {
      txt += ": " + message.content;
    } else {
      txt += " sent you a image.";
    }
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: Text(
            txt,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Text(
            " - " + DateConverter.getTime(message.timeStamp),
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
