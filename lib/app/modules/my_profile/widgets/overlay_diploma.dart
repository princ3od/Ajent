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
  final VoidCallback onClickConfirm;
  final VoidCallback onClickCancel;
  final Function onDelete;
  final MyProfileController controller = Get.find<MyProfileController>();

  DiplomaLayout(
      {Key key,
      @required this.onClickConfirm,
      @required this.onClickCancel,
      @required this.onDelete})
      : super(key: key);

  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      controller.image.value = File(pickedFile.path);
      print('line29');
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    String description = '';
    String title = '';
    String url = '';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text('add_diploma_overlay_title'.tr),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.withOpacity(0.5),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 80,
                child: ClipOval(
                  child: controller.image != null
                      ? Image.file(controller.image.value)
                      : Image.asset('assets/images/ajent_logo.png'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () async {
                  await getImage();
                },
                child: Text('add_diploma_overlay_pick_image_label'.tr),
              ),
              SizedBox(
                height: 20,
              ),
              Text('add_diploma_overlay_title_label'.tr,
                  style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: primaryTextFieldDecoration,
                  cursorColor: primaryColor,
                  onChanged: (value) {
                    title = value;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text('add_diploma_overlay_description_label'.tr,
                  style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: primaryTextFieldDecoration,
                  cursorColor: primaryColor,
                  onChanged: (value) {
                    description = value;
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
                    onPressed: () {
                      controller.overDegee.title = title;
                      controller.overDegee.description = description;
                      controller.overDegee.imageUrl = url;
                      onDelete();
                      // onClickConfirm();
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
                        onDelete();
                        // onClickCancel();
                      },
                      label: Text('add_diploma_layout_cancel_label'.tr)),
                ],
              ),
              TextButton(
                  onPressed: () {
                    print('Url: ' + controller.overDegee.imageUrl);
                    print('Title: ' + controller.overDegee.title);
                    print('Description: ' + controller.overDegee.description);
                  },
                  child: Text('Test')),
            ],
          ),
        ),
      ),
    );
  }
}
