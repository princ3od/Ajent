import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
class ProfileViewPage extends StatelessWidget{
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
          "Some Ajent's user",
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
                    backgroundImage: AssetImage(
                        "assets/images/ajent_logo.png"),
                    radius: 40.0,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '2.3'
                  ),
                  Icon(Icons.star),

                ],

              ),
              Center(
                  child: IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.chat_rounded))),
              Text("ajent_user_name_label".tr,
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.bold, fontSize: 12)),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: TextFormField(
                  initialValue: 'Trần Văn A',
                  readOnly: true,
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                ),
              ),
              Text("email_label".tr,
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.bold, fontSize: 12)),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: TextFormField(
                  initialValue: "ajentuseremail@gmail.com", //Get a link here to get to google maps.
                  decoration: primaryTextFieldDecoration,
                  readOnly: true,
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),

              SizedBox(height: 8),

              Text("phone_number_label".tr,
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.bold, fontSize: 12)),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: TextFormField(
                  initialValue: "092818281", //Get a link here to get to google maps.
                  readOnly: true,
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),

              SizedBox(height: 8),
              SizedBox(
                height: 8,
              ),
              Text('ajent_user_major_label'.tr,
                  style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold, fontSize: 12)),
              TextFormField(
               initialValue: "Sư phạm toán",
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
                style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold,fontSize: 12),
              ),
              TextFormField(
                initialValue: "Đại học",
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
                style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold,fontSize: 12),
              ),
              TextFormField(
                initialValue: "Not thing much, just ajent's example",
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