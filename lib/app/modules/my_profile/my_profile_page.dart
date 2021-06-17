import 'dart:ui';

import 'package:ajent/app/global_widgets/user_avatar.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/app/modules/my_profile/my_profile_controller.dart';
import 'package:ajent/app/modules/my_profile/widgets/degrees_tab.dart';
import 'package:ajent/app/modules/my_profile/widgets/information_tab.dart';

import 'package:ajent/core/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MyProfilePage extends StatelessWidget {
  final MyProfileController controller = Get.find<MyProfileController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Obx(
          () => Visibility(
            visible: (controller.tabIndex.value > 0),
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                //
              },
            ),
          ),
        ),
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 165,
                  width: Get.width,
                  child: Obx(
                    () => FadeInImage.assetNetwork(
                      placeholder: 'assets/images/default_profile_bg.jpg',
                      image: controller.ajentUser.value.avatarUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 165,
                  width: Get.width,
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Container(
                        color: Colors.black.withOpacity(0.4),
                      )),
                ),
                IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_sharp,
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: () {
                      controller.tabIndex.value = 0;
                      Get.back();
                    }),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: Obx(
                        () => Center(
                          child: Hero(
                            tag: '${HomeController.mainUser.uid} avatar',
                            child: UserAvatar(
                              user: controller.ajentUser.value,
                              size: 45,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(controller.ajentUser.value.name,
                          style: GoogleFonts.nunitoSans(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    width: 105,
                    height: 105,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: ClipOval(
                        child: Container(
                          width: 30,
                          height: 30,
                          color: Colors.grey.shade400,
                          child: InkWell(
                            splashColor: primaryColor,
                            customBorder: CircleBorder(),
                            onTap: () {
                              controller.onChangeAvatar();
                            },
                            child: Obx(
                              () => controller.isUpdatingAvatar.value
                                  ? SizedBox(
                                      height: 16,
                                      width: 16,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    )
                                  : Icon(
                                      Icons.edit,
                                      size: 20,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(
                () => CupertinoSegmentedControl(
                  groupValue: controller.tabIndex.value,
                  children: {
                    0: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: Text(
                          "Thông tin",
                          style: GoogleFonts.nunitoSans(),
                        )),
                    1: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: Text(
                          "Bằng cấp",
                          style: GoogleFonts.nunitoSans(),
                        )),
                    2: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: Text(
                          "Học sinh",
                          style: GoogleFonts.nunitoSans(),
                        )),
                  },
                  onValueChanged: (value) {
                    controller.tabIndex.value = value;
                    if (value == 1 && !controller.loadDegree.value) {
                      controller.loadUserDegree();
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Obx(
                  () => Column(
                    children: [
                      if (controller.tabIndex.value == 0) InformationTab(),
                      if (controller.tabIndex.value == 1) DegreesTab(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
