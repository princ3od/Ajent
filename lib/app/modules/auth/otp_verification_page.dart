import 'package:ajent/app/modules/auth/auth_controller.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationPage extends StatelessWidget {
  final AuthController controller = Get.put<AuthController>(AuthController());
  final String number = Get.arguments.toString();

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
            FocusScope.of(context).unfocus();
            Get.back();
          },
        ),
      ),
      body: Container(
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
              child: Image.asset("assets/images/otp_page_image.png"),
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
                          'verification_text'.tr,
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
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.black, fontSize: 15),
                              children: [
                                TextSpan(text: 'enter_otp_text'.tr),
                                TextSpan(
                                    text: number,
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.bold)),
                              ]),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(35, 25, 35, 20),
                            child: Obx(
                              () => PinCodeTextField(
                                enabled: !(controller.isVerifing.value),
                                autoFocus: true,
                                controller: controller.txtCode,
                                length: 6,
                                obscureText: false,
                                animationType: AnimationType.scale,
                                keyboardType: TextInputType.number,
                                cursorColor: primaryColor,
                                pinTheme: PinTheme(
                                  inactiveColor: Colors.grey.withAlpha(200),
                                  activeColor: primaryColor.withAlpha(120),
                                  selectedColor: primaryColor,
                                  shape: PinCodeFieldShape.underline,
                                  fieldHeight: 50,
                                  fieldWidth: 40,
                                ),
                                animationDuration: Duration(milliseconds: 80),
                                onCompleted: (v) {
                                  FocusScope.of(context).unfocus();
                                  controller.verifyCode();
                                },
                                appContext: context,
                                onChanged: (String value) {},
                              ),
                            )),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: SizedBox(
                          width: Get.height / 3,
                          child: ElevatedButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              controller.verifyCode();
                            },
                            child: Obx(
                              () => (controller.isVerifing.value)
                                  ? SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    )
                                  : Text('verify'.tr,
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.bold)),
                            ),
                            style: primaryButtonSytle,
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('not_receive_text'.tr,
                                style: GoogleFonts.nunitoSans()),
                            Obx(
                              () => TextButton(
                                style: TextButton.styleFrom(
                                  primary: primaryColor,
                                ),
                                onPressed: (controller.timeOut > 0)
                                    ? null
                                    : () {
                                        controller.resendOTP();
                                      },
                                child: (controller.isSendingOTP.value)
                                    ? SizedBox(
                                        height: 15,
                                        width: 15,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  primaryColor),
                                        ),
                                      )
                                    : Text(
                                        (controller.timeOut <= 0)
                                            ? 'resend'.tr
                                            : 'resend'.tr +
                                                " (00:" +
                                                controller.timeOut
                                                    .toString()
                                                    .padLeft(2, '0') +
                                                ")",
                                        style: GoogleFonts.nunitoSans(
                                            color: (controller.timeOut <= 0)
                                                ? primaryColor
                                                : Colors.grey.shade400,
                                            fontSize: 16),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
            //Expanded(flex: 1, child: Material())
          ],
        ),
      ),
    );
  }
}
