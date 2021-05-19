import 'package:ajent/app/modules/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

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
          onPressed: () {
            timeDilation = 2.0;
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
                flex: 1,
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: TextField(
                            controller: controller.txtPhoneNumber,
                          )),
                      ElevatedButton(
                          onPressed: () {
                            controller.loginWithPhone();
                          },
                          child: Text("Gửi")),
                      Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: TextField(
                            controller: controller.txtCode,
                          )),
                      ElevatedButton(
                          onPressed: () {
                            controller.verifyCode();
                          },
                          child: Text("Xác thực")),
                    ],
                  ),
                ),
              ),
              //Expanded(flex: 1, child: Material())
            ],
          ),
        ),
      ),
    );
  }
}
