import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/global_widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewUserPlaceHolder extends StatelessWidget {
  final AjentUser user;
  NewUserPlaceHolder(this.user);
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserAvatar(user: user, size: 50),
            SizedBox(height: 10),
            Text(
              user.name,
              style: GoogleFonts.nunitoSans(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Start new chat with ${user.name} now!'),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
