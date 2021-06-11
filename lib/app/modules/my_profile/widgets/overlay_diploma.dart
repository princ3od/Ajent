import 'package:ajent/app/modules/my_profile/my_profile_controller.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DiplomaLayout extends StatelessWidget {
  final MyProfileController controller;
  final VoidCallback onClickConfirm;
  final VoidCallback onClickCancel;
  final Function onClosedDiplomaOverlay;

  const DiplomaLayout(
      {Key key,
      this.controller,
      this.onClickConfirm,
      this.onClickCancel,
      this.onClosedDiplomaOverlay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('add_diploma_dialog'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('add_diploma_dialog_message'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('add_diploma_approve_label'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    Get.put(this.controller);
    final picker = ImagePicker();
    Future getImage() async {
      final pickedFile = await picker.getImage(source: ImageSource.camera);

      if (pickedFile != null) {
        controller.image.value = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text('add_diploma_overlay_title'.tr),
      ),
      //resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.withOpacity(0.5),
      body: Center(
        child: Container(
          width: double.infinity,
          height: 800,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Obx(() => Container(
                      height: 150,
                      child: (controller.image.value.path == '')
                          ? CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 80,
                              child: Container(
                                child: Image.asset(
                                  'assets/images/ajent_logo.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 80,
                              child: Container(
                                child: Image.file(
                                  controller.image.value,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    )),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () async {
                    await getImage(); // Here..... code de lay anh
                  },
                  child: Text(
                    'add_diploma_overlay_pick_image_label'.tr,
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('add_diploma_overlay_title_label'.tr,
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.bold, fontSize: 20)),
                SizedBox(
                  width: 300,
                  child: TextField(
                    maxLines: null,
                    decoration: primaryTextFieldDecoration,
                    cursorColor: primaryColor,
                    onChanged: (value) {
                      controller.title.value = value;
                      print(controller.title.value);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('add_diploma_overlay_description_label'.tr,
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.bold, fontSize: 20)),
                SizedBox(
                  width: 300,
                  child: TextField(
                    maxLines: null,
                    decoration: primaryTextFieldDecoration,
                    cursorColor: primaryColor,
                    onChanged: (value) {
                      controller.description.value = value;
                      print(controller.description.value);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () async {
                        if (controller.isAvaiableDegreeInfo()) {
                          String imageUrl = await controller.storageService
                              .uploadImage(controller.image.value,
                                  controller.ajentUser.value.uid);
                          print(imageUrl);
                          controller.overDegee.imageUrl = imageUrl;
                          controller.overDegee.title = controller.title.value;
                          controller.overDegee.description =
                              controller.description.value;

                          await controller.userService.addDegree(
                              controller.ajentUser.value.uid,
                              controller.overDegee);
                          onClosedDiplomaOverlay(context);
                        } else {
                          await _showMyDialog();
                        }
                      },
                      label: Text('add_diploma_layout_confirm_label'.tr),
                      icon: Icon(Icons.check),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    TextButton.icon(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          onClosedDiplomaOverlay(context);
                          // onClickCancel();
                        },
                        label: Text('add_diploma_layout_cancel_label'.tr)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
