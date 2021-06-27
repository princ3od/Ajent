import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/models/Person.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final AjentUser user;
  final int size;
  const UserAvatar({
    Key key,
    @required this.user,
    @required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white60,
      radius: size * 1.0,
      child: ClipOval(
        child: FadeInImage.assetNetwork(
          fadeInDuration: Duration(milliseconds: 200),
          fadeOutDuration: Duration(milliseconds: 180),
          placeholder: (this.user.gender == Gender.male)
              ? "assets/images/default_avatar_male.png"
              : "assets/images/default_avatar_female.png",
          image: this.user.avatarUrl ?? "",
          width: 85,
          height: 85,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
