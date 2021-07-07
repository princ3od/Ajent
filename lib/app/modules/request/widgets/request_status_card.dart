import 'package:ajent/app/data/models/Request.dart';
import 'package:ajent/app/data/models/requestStatusCardData.dart';
import 'package:ajent/app/modules/request/widgets/request_status_badge.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/utils/date_converter.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestStatusCard extends StatelessWidget {
  final RequestStatusCardData data;
  final ValueChanged<RequestStatusCardData> onDenied;
  final ValueChanged<Request> onContact;

  const RequestStatusCard({
    Key key,
    @required this.data,
    @required this.onDenied,
    @required this.onContact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
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
                    flex: 6,
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 3, left: 15),
                            child: SizedBox(
                              width: Get.width,
                              child: Text(
                                "You have requested to become a teacher of this course"
                                    .tr,
                                maxLines: 2,
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 5),
                                child: Text(
                                  "State: ".tr,
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                      color: Colors.black),
                                ),
                              ),
                              RequestStatusBadege(
                                  status: data.request?.status ??
                                      RequestStatus.waiting),
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
                                      "Sent " +
                                          "${DateConverter.getTimeInAgo(data.request.postDate)}",
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => onDenied(data),
                      child: Text(
                        (data.request.status == RequestStatus.waiting)
                            ? "Cancel request".tr
                            : "Delete request".tr,
                        style: GoogleFonts.nunitoSans(
                            fontSize: 12.5, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => onContact(this.data.request),
                      child: Text(
                        "Contact".tr,
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
