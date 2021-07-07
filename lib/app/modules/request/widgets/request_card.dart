import 'dart:math';

import 'package:ajent/app/data/models/Request.dart';
import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/models/requestCardData.dart';
import 'package:ajent/app/data/services/user_service.dart';
import 'package:ajent/app/global_widgets/user_avatar.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/app/modules/request/widgets/request_status_badge.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/utils/date_converter.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestCard extends StatelessWidget {
  final RequestCardData data;
  final ValueChanged<RequestCardData> onApprovePressed;
  final ValueChanged<RequestCardData> onDeniedPressed;

  const RequestCard(
      {Key key,
      @required this.data,
      this.onApprovePressed,
      this.onDeniedPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Course".tr,
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.white, fontSize: 10)),
                              SizedBox(height: 3),
                              Row(
                                children: [
                                  CircleAvatar(
                                    child: ClipOval(
                                      child: FadeInImage.assetNetwork(
                                        fadeInDuration:
                                            Duration(milliseconds: 200),
                                        fadeOutDuration:
                                            Duration(milliseconds: 180),
                                        placeholder:
                                            'assets/images/ajent_logo.png',
                                        image: data.course?.photoUrl ?? "",
                                        width: 100,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    radius: 12.0,
                                  ),
                                  SizedBox(width: 5),
                                  SizedBox(
                                    width: Get.width - 100,
                                    child: Text(
                                      data.course?.name ?? "Course's name",
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      style: GoogleFonts.nunitoSans(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
                  Expanded(
                    flex: 7,
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                                child: UserAvatar(
                                  user: data.requestor,
                                  size: 16,
                                ),
                              ),
                              Flexible(
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.PROFILEVIEW,
                                        arguments: data.requestor);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        (data.requestor.uid ==
                                                HomeController.mainUser.uid)
                                            ? 'you'.tr
                                            : data.requestor.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                      (data.star != -1)
                                          ? RatingBar.builder(
                                              itemSize: 15,
                                              ignoreGestures: true,
                                              itemCount: 5,
                                              initialRating: (data.star != null)
                                                  ? data.star
                                                  : 2.0,
                                              itemBuilder: (context, index) =>
                                                  Icon(
                                                Icons.star_rounded,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (value) {},
                                            )
                                          : Text(
                                              'No rating'.tr,
                                              style: GoogleFonts.nunito(
                                                  fontSize: 12),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 3, left: 20),
                                child: SizedBox(
                                  width: Get.width - 60,
                                  child: Text(
                                    "${data.requestor.name} " +
                                        "want to teach this course".tr,
                                    maxLines: 2,
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, bottom: 5),
                                    child: Text(
                                      "Sent ".tr +
                                          " ${DateConverter.getTimeInAgo(data.request.postDate)}",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                          color: Colors.black54),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Transform.rotate(
                      angle: pi / 180 * 25,
                      child: RequestStatusBadege(
                          status:
                              data.request?.status ?? RequestStatus.accepted),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: (data.request != null)
                          ? ((data.request.status != null)
                              ? ((data.request.status !=
                                          RequestStatus.accepted &&
                                      data.request.status !=
                                          RequestStatus.denied)
                                  ? () {
                                      onDeniedPressed(this.data);
                                    }
                                  : null)
                              : null)
                          : null,
                      child: Text(
                        "Decline".tr,
                        style: GoogleFonts.nunitoSans(
                            fontSize: 12.5, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: (data.request != null)
                          ? ((data.request.status != null)
                              ? ((data.request.status !=
                                          RequestStatus.accepted &&
                                      data.request.status !=
                                          RequestStatus.denied)
                                  ? () {
                                      onApprovePressed(this.data);
                                    }
                                  : null)
                              : null)
                          : null,
                      child: Text(
                        "Approve".tr,
                        style: GoogleFonts.nunitoSans(
                            fontSize: 12.5, fontWeight: FontWeight.bold),
                      ),
                      style: primaryButtonSytle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
