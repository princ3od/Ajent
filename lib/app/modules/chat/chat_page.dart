import 'package:ajent/app/data/models/message.dart';
import 'package:ajent/app/global_widgets/user_avatar.dart';
import 'package:ajent/app/modules/chat/widgets/message_item.dart';
import 'package:ajent/app/modules/chat/widgets/new_user_placeholder.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'chat_controller.dart';

class ChatPage extends StatelessWidget {
  final partner = Get.arguments;
  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.put(ChatController(partner));
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: GestureDetector(
          onTap: () {
            Get.toNamed(Routes.PROFILEVIEW, arguments: controller.partner);
          },
          child: Row(
            children: [
              UserAvatar(user: partner, size: 18),
              SizedBox(width: 10),
              Text(
                partner.name,
                style: GoogleFonts.nunitoSans(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                Get.toNamed(Routes.PROFILEVIEW, arguments: controller.partner);
              })
        ],
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: Obx(
                  () => (!controller.isLoading.value)
                      ? Scrollbar(
                          showTrackOnHover: true,
                          thickness: 5.0,
                          //controller: _chatController.scrollController,
                          child: ListView.builder(
                            itemCount: controller.messages.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: (index == 0) ? 5 : 0),
                                child: ListTile(
                                  dense: true,
                                  visualDensity: VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  title: MessageItem(
                                    message: controller.messages[index],
                                    showTime: controller.needShowTime(index),
                                    fromPartner: (controller.user.uid !=
                                        controller.messages[index].senderUid),
                                    partner: controller.partner,
                                    showAvatar:
                                        (controller.messages[index].type ==
                                                MessageType.image ||
                                            controller.isLastLeft(index)),
                                  ),
                                ),
                              );
                            },
                            reverse: true,
                          ),
                        )
                      : Center(child: CircularProgressIndicator()),
                ),
              ),
              buildInput(controller),
            ],
          ),
          Obx(
            () => AnimatedOpacity(
              opacity: (controller.isNewUser.value) ? 1 : 0,
              child: NewUserPlaceHolder(partner),
              duration: Duration(milliseconds: 500),
            ),
          )
          // Loading
        ],
      ),
    );
  }

  Widget buildInput(ChatController controller) {
    return Container(
      child: Row(
        children: <Widget>[
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: Icon(Icons.image),
                onPressed: () {
                  controller.sendImage();
                },
              ),
            ),
            color: Colors.white,
          ),
          Flexible(
            child: Container(
              child: TextField(
                controller: controller.txtContent,
                onSubmitted: (value) {
                  controller.sendTextMessage();
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: GoogleFonts.nunitoSans(color: Colors.grey),
                ),
              ),
            ),
          ),
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  controller.sendTextMessage();
                },
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
          color: Colors.white),
    );
  }
}
