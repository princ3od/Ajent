import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../../../core/utils/date_converter.dart';
import '../../data/models/ajent_user.dart';
import '../../data/models/evaluation.dart';
import '../../global_widgets/user_avatar.dart';
import '../home/home_controller.dart';

class ARatingCard extends StatelessWidget {
  final AjentUser user;
  final Evaluation evaluation;
  ARatingCard({
    @required this.user,
    @required this.evaluation,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: UserAvatar(
                      user: user,
                      size: 20,
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (user.uid == HomeController.mainUser.uid)
                              ? 'you'.tr
                              : user.name,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RatingBar.builder(
                              itemSize: 16,
                              ignoreGestures: true,
                              itemCount: 5,
                              initialRating: evaluation.star.toDouble(),
                              itemBuilder: (context, index) => Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (value) {},
                            ),
                            Text(
                              DateConverter.getTime(evaluation.postDate, true),
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.nunitoSans(
                                  fontSize: 13, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              content: Scrollbar(
                isAlwaysShown: true,
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          evaluation.content,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1000,
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        shadowColor: Colors.grey[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: UserAvatar(
                    user: user,
                    size: 20,
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (user.uid == HomeController.mainUser.uid)
                            ? 'you'.tr
                            : user.name,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Colors.black),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingBar.builder(
                            itemSize: 16,
                            ignoreGestures: true,
                            itemCount: 5,
                            initialRating: evaluation.star.toDouble(),
                            itemBuilder: (context, index) => Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (value) {},
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Text(
                              DateConverter.getTimeInAgo(evaluation.postDate),
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.nunitoSans(
                                  fontSize: 13, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 10, 15),
              child: Text(
                evaluation.content,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w400),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
