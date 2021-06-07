import 'package:ajent/app/data/models/AjentUser.dart';
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
      backgroundColor: Colors.white,
      radius: this.size * 1.0,
      child: ClipOval(
        child: FadeInImage.assetNetwork(
            placeholder: (this.user.gender == Gender.male)
                ? "assets/images/default_avatar_male.png"
                : "assets/images/default_avatar_female.png",
            image: this.user.avatarUrl ?? ""),
        // child: Image.network(
        //   this.user.avatarUrl ?? "",
        //   errorBuilder: (context, error, stackTrace) => Image.asset(
        //       (this.user.gender == Gender.male)
        //           ? "assets/images/default_avatar_male"
        //           : "assets/images/default_avatar_female"),
        //   loadingBuilder: (context, child, loadingProgress) =>
        //       CircularProgressIndicator(),
        // ),
      ),
    );
  }
}
