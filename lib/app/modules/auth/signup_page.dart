import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class SignupPage extends StatelessWidget {
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
                child: Material(child: TextField()),
              ),
              Expanded(flex: 2, child: Material())
            ],
          ),
        ),
      ),
    );
  }
}
