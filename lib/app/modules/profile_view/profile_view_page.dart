import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/modules/profile_view/profile_view_controller.dart';
import 'package:ajent/core/themes/widget_theme.dart';
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
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
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
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      )
                    else if (controller.averageStar.value == -1.0)
                      Text('Chưa có')
                    else
                      Text(controller.averageStar.value.toStringAsFixed(2)),
                    Icon(Icons.star),
                  ],
                ),
              ),
              Center(
                child: InkWell(
                  onTap: (){
                    Get.toNamed(Routes.VIEWRATING);
                  },
                  child: Column(
                    children: [
                      Text(
                        "220 lượt đánh giá",
                        style: GoogleFonts.nunitoSans(fontSize: 12, fontWeight: FontWeight.normal),
                      ),
                      Text("(tap vào để xem chi tiết)", style: GoogleFonts.nunitoSans(fontSize: 10,fontWeight: FontWeight.w200),)
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
              Text("ajent_user_name_label".tr,
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.bold, fontSize: 12)),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: TextFormField(
                  initialValue: user.name,
                  readOnly: true,
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
              Text("email_label".tr,
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: TextFormField(
                  onTap: () async {
                    if (user.mail != null && user.mail.isNotEmpty) {
                      await launch('mailto: ${user.mail}');
                    }
                  },
                  initialValue: (user.mail == null)
                      ? "Không có"
                      : (user.mail.isEmpty)
                          ? "Không có"
                          : user.mail, //Get a link here to get to google maps.
                  decoration: primaryTextFieldDecoration,
                  readOnly: true,
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: (user.mail != null && user.mail.isNotEmpty)
                          ? Colors.blue
                          : Colors.black),
                ),
              ),
              SizedBox(height: 8),
              Text("phone_number_label".tr,
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.bold, fontSize: 12)),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: TextFormField(
                  onTap: () async {
                    if (user.phone != null && user.phone.isNotEmpty) {
                      await launch('tel: ${user.phone}');
                    }
                  },
                  initialValue: (user.phone == null)
                      ? "Không có"
                      : (user.phone.isEmpty)
                          ? "Không có"
                          : user.phone, //Get a link here to get to google maps.
                  readOnly: true,
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: (user.phone != null && user.mail.isNotEmpty)
                        ? Colors.blue
                        : Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 8),
              SizedBox(
                height: 8,
              ),
              Text('ajent_user_major_label'.tr,
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.bold, fontSize: 12)),
              TextFormField(
                initialValue: user.major,
                readOnly: true,
                style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'ajent_user_education_level_label'.tr,
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.bold, fontSize: 12),
              ),
              TextFormField(
                initialValue: user.educationLevel,
                readOnly: true,
                style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'ajent_bio_label'.tr,
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.bold, fontSize: 12),
              ),
              TextFormField(
                initialValue: user.bio,
                readOnly: true,
                style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
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
