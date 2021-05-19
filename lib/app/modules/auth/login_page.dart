import 'package:ajent/app/modules/auth/auth_controller.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final AuthController controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            size: 30,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Hero(
                tag: "logo",
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.asset("assets/images/ajent_logo.png"),
                      width: 100,
                      height: 100,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        "Ajent",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        "Move forward",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Obx(() => controller.isSigningIn.value
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(),
                        ),
                        SizedBox(height: 10),
                        Text("Đợi xíu, Ajent đang đăng nhập cho bạn..."),
                      ],
                    )
                  : buildSignIn()),
            ),
            Hero(
              child: Container(
                height: 0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(400),
                    topRight: Radius.circular(400),
                  ),
                ),
              ),
              tag: "bottom bar",
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSignIn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ButtonWithLeadIcon(
              onPressed: () => controller.loginWithGoogle(),
              text: "Tiếp tục với Google",
              path: "assets/images/google_logo.png",
            ),
          ),
        ),
        SizedBox(height: 2),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ButtonWithLeadIcon(
              onPressed: () => controller.loginWithFacebook(),
              text: "Tiếp tục với Facebook",
              path: "assets/images/fb_logo.png",
            ),
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
              ),
            ),
            Text(
              "HOẶC",
              style: TextStyle(color: Colors.white),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ButtonWithLeadIcon(
              onPressed: () => controller.loginWithPhone(),
              text: "Đăng nhập bằng số điện thoại",
              path: "assets/images/phone.png",
            ),
          ),
        ),
        SizedBox(height: 25)
      ],
    );
  }
}

class ButtonWithLeadIcon extends StatelessWidget {
  final String text;
  final String path;
  final Function onPressed;
  const ButtonWithLeadIcon({
    Key key,
    @required this.text,
    @required this.path,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                  child: Image.asset(
                path,
                width: 25,
                height: 25,
              )),
            ),
            Expanded(
              flex: 5,
              child: Text(text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: primaryColor,
          padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
        ));
  }
}
