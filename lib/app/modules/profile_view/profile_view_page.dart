import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/modules/profile_view/profile_view_controller.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileViewPage extends StatelessWidget {
  final AjentUser user = Get.arguments;
  final ProfileViewController controller =
      Get.put<ProfileViewController>(ProfileViewController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.grey[100],
        toolbarHeight: 70.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          user.name,
          style: GoogleFonts.nunitoSans(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: ClipOval(
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/ajent_logo.png',
                          image: user.avatarUrl,
                          width: 100,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      radius: 40.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(user.name),
                    )
                  ],
                ),
              ),
              Obx(
                () => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (controller.averageStar.value == -2.0)
                      SizedBox(
                        height: 12,
                        width: 12,
                        child: CircularProgressIndicator(
                          strokeWidth: 3.0,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      )
                    else if (controller.averageStar.value == -1.0)
                      Text('Not available'.tr)
                    else
                      Text(controller.averageStar.value.toStringAsFixed(2)),
                    Icon(
                      Icons.star,
                      color: Colors.yellow.shade600,
                    ),
                  ],
                ),
              ),
              Center(
                child: InkWell(
                  onTap: () => (controller.averageStar.value > -1.0)
                      ? Get.toNamed(Routes.VIEWRATING,
                          arguments: controller.evaluations)
                      : null,
                  child: Column(
                    children: [
                      Obx(
                        () => Text(
                          (controller.reviewNum.value > -1)
                              ? (controller.reviewNum.value > 0)
                                  ? "${controller.reviewNum.value} "+ "ratings".tr
                                  : "No rating".tr
                              : "-- ratings",
                          style: GoogleFonts.nunitoSans(
                              fontSize: 12, fontWeight: FontWeight.normal),
                        ),
                      ),
                      Text(
                        "(tap to see detail)".tr,
                        style: GoogleFonts.nunitoSans(
                            fontSize: 10, fontWeight: FontWeight.w200),
                      )
                    ],
                  ),
                ),
              ),
              Center(
                  child: IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.CHATTING, arguments: user);
                      },
                      icon: Icon(Icons.chat_rounded))),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Text("Contact information".tr,
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w800, fontSize: 17)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: Text("email_label".tr,
                    style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: TextFormField(
                  onTap: () async {
                    if (user.mail != null && user.mail.isNotEmpty) {
                      await launch('mailto: ${user.mail}');
                    }
                  },
                  initialValue: (user.mail == null)
                      ? "Not available".tr
                      : (user.mail.isEmpty)
                          ? "Not available".tr
                          : user.mail, //Get a link here to get to google maps.
                  decoration: primaryTextFieldDecoration,
                  readOnly: true,
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: (user.mail != null && user.mail.isNotEmpty)
                          ? primaryColor
                          : Colors.black),
                ),
              ),
              Text("phone_number_label".tr,
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w600, fontSize: 12)),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: TextFormField(
                  onTap: () async {
                    if (user.phone != null && user.phone.isNotEmpty) {
                      await launch('tel: ${user.phone}');
                    }
                  },
                  initialValue: (user.phone == null)
                      ? "Not available".tr
                      : (user.phone.isEmpty)
                          ?  "Not available".tr
                          : user.phone, //Get a link here to get to google maps.
                  readOnly: true,
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: (user.phone != null && user.mail.isNotEmpty)
                        ? primaryColor
                        : Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 8),
                child: Text("Qualification".tr,
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w800, fontSize: 17)),
              ),
              Text('ajent_user_major_label'.tr,
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w600, fontSize: 12)),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: TextFormField(
                  initialValue: user.major,
                  readOnly: true,
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              Text(
                'ajent_user_education_level_label'.tr,
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w600, fontSize: 12),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: TextFormField(
                  initialValue: user.educationLevel,
                  readOnly: true,
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              Text(
                'ajent_bio_label'.tr,
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w600, fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: TextFormField(
                  initialValue: user.bio,
                  readOnly: true,
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Center(
                      child: Text("© Ajent ",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w100, fontSize: 12))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
