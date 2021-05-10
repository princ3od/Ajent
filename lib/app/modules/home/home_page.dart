import 'package:ajent/app/modules/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Ajent Homepage"),
            ElevatedButton.icon(
              onPressed: () {
                Get.put<AuthController>(AuthController()).signOutGoogle();
              },
              icon: Icon(Icons.logout),
              label: Text("Đăng xuất"),
            ),
          ],
        ),
      ),
    );
  }
}
