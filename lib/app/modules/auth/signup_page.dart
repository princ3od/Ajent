import 'package:ajent/app/modules/auth/auth_controller.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatelessWidget {
  final AuthController controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            size: 30,
            color: Colors.black,
          ),
          onPressed: () async {
            if (controller.isSendingOTP.value) {
              return;
            }
            FocusScope.of(context).unfocus();
            Get.back();
          },
        ),
      ),
      body: Hero(
        tag: "bottom bar",
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(400),
              topRight: Radius.circular(400),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Image.asset("assets/images/phone_login_page.png"),
              ),
              Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: Text(
                            'please_input_phone'.tr,
                            style: GoogleFonts.nunitoSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Material(
                          color: Colors.transparent,
                          child: RichText(
                            text: TextSpan(
                                style:
                                    GoogleFonts.nunitoSans(color: Colors.black),
                                children: [
                                  TextSpan(text: 'send_otp_text_1'.tr),
                                  TextSpan(
                                      text: 'otp'.tr,
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: 'send_otp_text_2'.tr),
                                ]),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(35, 25, 35, 25),
                            child: Obx(
                              () => TextField(
                                enabled: !controller.isSendingOTP.value,
                                onSubmitted: (txt) =>
                                    controller.loginWithPhone(),
                                controller: controller.txtPhoneNumber,
                                style: GoogleFonts.nunitoSans(),
                                maxLength: 13,
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: primaryColor)),
                                  labelText: 'phone_number'.tr,
                                  labelStyle: GoogleFonts.nunitoSans(
                                      color: primaryColor),
                                  hintText: "+966",
                                ),
                                keyboardType: TextInputType.phone,
                              ),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: SizedBox(
                            width: Get.height / 3,
                            child: ElevatedButton(
                              onPressed: () {
                                if (controller.isSendingOTP.value) {
                                  return;
                                }
                                controller.txtCode = TextEditingController();
                                controller.loginWithPhone();
                                // Get.offAndToNamed(Routes.VERIFICATION,
                                //     arguments: controller.txtPhoneNumber.text);
                              }, //,
                              child: Obx(
                                () => (controller.isSendingOTP.value)
                                    ? SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        ),
                                      )
                                    : Text('send'.tr,
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w600)),
                              ),
                              style: primaryButtonSytle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
