import 'package:ajent/app/data/models/AjentUser.dart';
import 'package:ajent/app/data/models/Person.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
      backgroundColor: Colors.grey,
      radius: this.size * 1.0,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: this.user.avatarUrl,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Image.asset(
              (this.user.gender == Gender.male)
                  ? "assets/images/default_avatar_male"
                  : "assets/images/default_avatar_female"),
        ),
      ),
    );
  }
}
