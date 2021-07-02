import 'package:ajent/app/data/models/Request.dart';
import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/modules/request/widgets/request_status_badge.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/utils/date_converter.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestStatusCard extends StatelessWidget {
  final Course course;
  final Request request;
  final ValueChanged<Request> onDenied;

  const RequestStatusCard({
    Key key,
    @required this.course,
    @required this.request,
    @required this.onDenied,
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
                              Text("Khoá học",
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
                                        image: course?.photoUrl ?? "",
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
                                      course?.name ?? "Course's name",
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
                                "Bạn đã yêu cầu trở thành giảng viên của khoá học này.",
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
                                  "Tình trạng: ",
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                      color: Colors.black),
                                ),
                              ),
                              RequestStatusBadege(
                                  status:
                                      request?.status ?? RequestStatus.waiting),
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
                                      "đã gửi ${DateConverter.getTimeInAgo(1624536554094)}",
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
                      onPressed: () => onDenied(this.request),
                      child: Text(
                        "Huỷ yêu cầu",
                        style: GoogleFonts.nunitoSans(
                            fontSize: 12.5, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Liên hệ",
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
