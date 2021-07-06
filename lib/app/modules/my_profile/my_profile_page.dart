import 'dart:ui';

import 'package:ajent/app/global_widgets/user_avatar.dart';
import 'package:ajent/app/modules/chat/widgets/full_image_page.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/app/modules/my_profile/my_profile_controller.dart';
import 'package:ajent/app/modules/my_profile/widgets/degrees_tab.dart';
import 'package:ajent/app/modules/my_profile/widgets/information_tab.dart';
import 'package:ajent/core/themes/widget_theme.dart';

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
          'my_profile_title_label'.tr,
          style: GoogleFonts.nunitoSans(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: Obx(
        () => Visibility(
          visible: (controller.tabIndex.value > 0),
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              if (controller.tabIndex.value == 0) {
                return;
              } else if (controller.tabIndex.value == 1) {
                controller.showAddDegreeSheet(context);
              } else {}
            },
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 15),
                    child: Obx(
                      () => Center(
                        child: Hero(
                          tag: '${HomeController.mainUser.uid} avatar',
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => FullImageScreen(
                                    imageURL:
                                        controller.ajentUser.value.avatarUrl,
                                    name: controller.ajentUser.value.name,
                                    tag:
                                        '${HomeController.mainUser.uid} avatar',
                                  ));
                            },
                            child: UserAvatar(
                              user: controller.ajentUser.value,
                              size: 45,
                            ),
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
                        )),
                  ),
                ],
              ),
              Center(
                child: Container(
                  width: 95,
                  height: 100,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ClipOval(
                      child: Container(
                        width: 30,
                        height: 30,
                        color: Colors.grey.shade400.withAlpha(220),
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
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.black),
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
            padding: const EdgeInsets.all(5.0),
            child: Obx(
              () => CupertinoSegmentedControl(
                selectedColor: primaryColor,
                pressedColor: primaryColor.withAlpha(120),
                borderColor: primaryColor,
                groupValue: controller.tabIndex.value,
                children: {
                  0: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: Text(
                        "Infomation".tr,
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w700, fontSize: 12),
                      )),
                  1: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: Text(
                        "Degrees".tr,
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w700, fontSize: 12),
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
          Obx(
            () => (controller.tabIndex.value != 0)
                ? Container()
                : Visibility(
                    visible: MediaQuery.of(context).viewInsets.bottom == 0,
                    child: Container(
                      height: kBottomNavigationBarHeight + 15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  await controller.updateInformation();
                                },
                                child: Obx(
                                  () => (controller.isUpdatingInfo.value)
                                      ? SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                          ),
                                        )
                                      : Text('profile_save_label'.tr,
                                          style: GoogleFonts.nunitoSans(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700)),
                                ),
                                style: orangeButtonStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
