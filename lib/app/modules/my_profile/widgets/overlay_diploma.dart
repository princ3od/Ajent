import 'package:ajent/app/modules/my_profile/my_profile_controller.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DiplomaLayoutWidget extends StatefulWidget {
  DiplomaLayoutWidget(
      {Key key,
      this.controller,
      this.onClickConfirm,
      this.onClickCancel,
      this.onDelete})
      : super(key: key);
  final MyProfileController controller;
  final VoidCallback onClickConfirm;
  final VoidCallback onClickCancel;
  final Function onDelete;

  @override
  _DiplomaLayoutWidgetState createState() => _DiplomaLayoutWidgetState();
}

class _DiplomaLayoutWidgetState extends State<DiplomaLayoutWidget> {
  File _image;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<MyProfileController>(() => widget.controller);
    String description = '';
    String title = '';
    String url = '';
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
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  child: ClipOval(
                    child: _image == null
                        ? Image.asset('assets/images/ajent_logo.png')
                        : Image.file(_image),
                  ),
                ),
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
                      title = value;
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
                        widget.controller.overDegee.title = title;
                        widget.controller.overDegee.description = description;
                        widget.controller.overDegee.imageUrl = url;
                        widget.onDelete();
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
                          widget.onDelete();
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
