import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/models/message.dart';
import 'package:ajent/app/global_widgets/user_avatar.dart';
import 'package:ajent/app/modules/chat/widgets/invitation_course_card.dart';
import 'package:ajent/core/utils/date_converter.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'full_image_page.dart';

class MessageItem extends StatelessWidget {
  final Message message;
  final bool showTime, fromPartner, showAvatar;
  final AjentUser partner;
  const MessageItem(
      {@required this.message,
      @required this.showTime,
      this.fromPartner = false,
      this.showAvatar = false,
      this.partner});

  @override
  Widget build(BuildContext context) {
    switch (message.type) {
      case MessageType.text:
        {
          if (!fromPartner) {
            return Column(
              children: [
                (showTime)
                    ? buildTimeText(message.timeStamp)
                    : Container(height: 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Container(
                        child: Text(
                          message.content,
                          style: TextStyle(color: Colors.white, fontSize: 13.5),
                        ),
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        margin: EdgeInsets.only(top: 5.0, left: 25.0),
                      ),
                    ),
                    Container(width: 5.0),
                  ],
                ),
              ],
            );
          } else {
            return Column(
              children: [
                (showTime)
                    ? buildTimeText(message.timeStamp)
                    : Container(height: 0),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (showAvatar)
                      UserAvatar(user: partner, size: 18)
                    else
                      SizedBox(
                        //height: 30,
                        width: 35,
                      ),
                    Flexible(
                      child: Container(
                        child: Text(
                          message.content,
                          style: TextStyle(color: Colors.black, fontSize: 13.5),
                        ),
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        margin:
                            EdgeInsets.only(top: 5.0, right: 25.0, left: 5.0),
                      ),
                    )
                  ],
                ),
              ],
            );
          }
          break;
        }
      case MessageType.image:
        return Column(
          children: [
            (showTime)
                ? buildTimeText(message.timeStamp)
                : Container(height: 0),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: (fromPartner)
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              children: [
                if (fromPartner) UserAvatar(user: partner, size: 18),
                SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: Get.width / 2 - 20,
                        maxHeight: Get.height / 2 - 40,
                        minHeight: 50,
                        minWidth: 100),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => FullImageScreen(
                              imageURL: message.content,
                              name: partner.name,
                            ));
                      },
                      child: Hero(
                        tag: message.content,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18.0),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/no_img.png',
                            image: message.content,
                            fadeInDuration: Duration(milliseconds: 300),
                            fadeOutDuration: Duration(milliseconds: 300),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
        break;
      case MessageType.invitation:
        return Column(
          children: [
            (showTime)
                ? buildTimeText(message.timeStamp)
                : Container(height: 0),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: (fromPartner)
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              children: [
                if (showAvatar && fromPartner)
                  UserAvatar(user: partner, size: 18)
                else if (fromPartner)
                  SizedBox(
                    height: 18,
                    width: 35,
                  ),
                Flexible(
                  child: InvitationCourseCard(
                    courseId: message.content,
                  ),
                ),
              ],
            ),
          ],
        );
        break;
      default:
        return Container();
    }
  }

  Center buildTimeText(int timeStamp) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 5),
        child: Text(
          DateConverter.getTime(timeStamp),
          style: GoogleFonts.nunitoSans(fontSize: 12),
        ),
      ),
    );
  }
}
