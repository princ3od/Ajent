import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/models/message.dart';
import 'package:ajent/app/global_widgets/user_avatar.dart';
import 'package:ajent/app/modules/chat/chat_controller.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class ShareableUserItem extends StatefulWidget {
  final AjentUser user;
  final String attachmentId;
  final MessageType type;
  const ShareableUserItem({
    Key key,
    @required this.user,
    @required this.attachmentId,
    this.type = MessageType.invitation,
  }) : super(key: key);

  @override
  _ShareableUserItemState createState() => _ShareableUserItemState();
}

class _ShareableUserItemState extends State<ShareableUserItem> {
  bool isSharing = false;
  bool isShared = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.user.name,
        style: GoogleFonts.nunitoSans(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: UserAvatar(user: widget.user, size: 20),
      trailing: OutlinedButton(
        onPressed: () async {
          if (isShared) {
            return;
          }
          setState(() {
            isSharing = true;
          });
          var m = ChatController.sendInvitation(
            widget.attachmentId,
            widget.user.uid,
            type: widget.type,
          );
          Get.snackbar("Send successfully".tr,
              "This attachment has been sent to".tr + " ${widget.user.name}",
              snackPosition: SnackPosition.TOP);
          setState(() {
            isSharing = false;
            isShared = (m != null);
          });
        },
        child: (isSharing)
            ? SizedBox(
                height: 15, width: 15, child: CircularProgressIndicator())
            : Text(
                (isShared) ? 'shared'.tr : 'share'.tr,
                style: GoogleFonts.nunitoSans(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
        style: outlinedButtonStyle,
      ),
    );
  }
}
