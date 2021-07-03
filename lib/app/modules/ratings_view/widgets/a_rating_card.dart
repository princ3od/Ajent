import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../../../../core/utils/date_converter.dart';
import '../../../data/models/ajent_user.dart';
import '../../../data/models/evaluation.dart';
import '../../../global_widgets/user_avatar.dart';
import '../../home/home_controller.dart';

class ARatingCard extends StatefulWidget {
  final AjentUser user;
  final Evaluation evaluation;
  final bool isExpandable;
  ARatingCard({
    @required this.user,
    @required this.evaluation,
    this.isExpandable = true,
  });

  @override
  _ARatingCardState createState() => _ARatingCardState();
}

class _ARatingCardState extends State<ARatingCard>
    with TickerProviderStateMixin {
  bool isExpand = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!widget.isExpandable) return;
        setState(() {
          isExpand = !isExpand;
        });
      },
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: UserAvatar(
                    user: widget.user,
                    size: 20,
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (widget.user.uid == HomeController.mainUser.uid)
                            ? 'you'.tr
                            : widget.user.name,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Colors.black),
                      ),
                      SingleChildScrollView(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RatingBar.builder(
                              itemSize: 15,
                              ignoreGestures: true,
                              itemCount: 5,
                              initialRating: widget.evaluation.star.toDouble(),
                              itemBuilder: (context, index) => Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (value) {},
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Text(
                                (isExpand)
                                    ? DateConverter.getTimeInDate(
                                        widget.evaluation.postDate)
                                    : DateConverter.getTimeInAgo(
                                        widget.evaluation.postDate),
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 12, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 10, 15),
              child: AnimatedSize(
                duration: Duration(milliseconds: 500),
                curve: Curves.fastLinearToSlowEaseIn,
                vsync: this,
                child: Text(
                  widget.evaluation.content,
                  maxLines: (isExpand) ? 100 : 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
