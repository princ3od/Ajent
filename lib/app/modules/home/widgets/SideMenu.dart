import 'package:ajent/app/modules/auth/auth_controller.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: 70,
                      height: 70,
                      child: Image.asset("assets/images/demo.png"),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Text(
                          "Duong Binh Trong",
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 12.0, left: 4.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: OutlinedButton(
                              onPressed: () {
                                Get.toNamed(Routes.PROFILE);
                              },
                              child: Text("Thông tin cá nhân"),
                              style: outlinedButtonStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButton(onPressed: () {}, child: Text("Lịch sử"))),
            SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButton(onPressed: () {}, child: Text("Cài đặt"))),
            SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButton(
                    onPressed: () {}, child: Text("Quy định & chính sách"))),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 5),
                        child: OutlinedButton(
                            onPressed: () {
                              Get.put<AuthController>(AuthController())
                                  .signOutGoogle();
                            },
                            child: Text(
                              "Đăng xuất",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600),
                            ),
                            style: OutlinedButton.styleFrom(
                              primary: Colors.red,
                              onSurface: primaryColor,
                              padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                              side: BorderSide(color: Colors.red, width: 1.6),
                            )),
                      )),
                  SizedBox(height: 5),
                  Text("© Ajent"),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
