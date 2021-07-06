import 'package:ajent/app/data/models/Request.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
class RequestStatusBadege extends StatelessWidget {
  final RequestStatus status;
  RequestStatusBadege({Key key, @required this.status}) : super(key: key);
  final Map<RequestStatus, String> texts = {
    RequestStatus.accepted: 'Accepted'.tr,
    RequestStatus.waiting: 'Waiting to response'.tr,
    RequestStatus.denied: 'Declined'.tr,
  };
  final Map<RequestStatus, Color> colors = {
    RequestStatus.accepted: Colors.green,
    RequestStatus.waiting: Colors.amber.shade700,
    RequestStatus.denied: Colors.red,
  };
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              color: colors[status],
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 0.5,
                  offset: Offset(0.0, 0.75),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Center(
              child: Text(texts[status],
                  maxLines: 1,
                  style: GoogleFonts.nunitoSans(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700)),
            ),
          ),
        ),
      ],
    );
  }
}
