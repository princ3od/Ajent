import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FileUtilitiy {
  static Future<File> getImage() async {
    ImageSource source;
    await Get.dialog(AlertDialog(
      title: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: TextButton(
                onPressed: () {
                  source = ImageSource.gallery;
                  Get.back();
                },
                child: Text('gallery'.tr)),
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
                onPressed: () {
                  source = ImageSource.camera;
                  Get.back();
                },
                child: Text('camera'.tr)),
          ),
        ],
      ),
    ));
    if (source == null) {
      return null;
    }
    final pickedFile = await ImagePicker().getImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      print('No image selected.');
      return null;
    }
  }
}
