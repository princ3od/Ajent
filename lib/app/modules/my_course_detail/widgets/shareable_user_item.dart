import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/global_widgets/user_avatar.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShareableUserItem extends StatelessWidget {
  final AjentUser user;
  final VoidCallback onShare;
  const ShareableUserItem({
    Key key,
    @required this.user,
    @required this.onShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        user.name,
        style: GoogleFonts.nunitoSans(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: UserAvatar(user: user, size: 20),
      trailing: OutlinedButton(
        onPressed: onShare,
        child: Text(
          'Share',
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
