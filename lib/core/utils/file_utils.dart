import 'dart:io';

import 'package:file_picker/file_picker.dart';
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

  static Future<File> pickImageOrPdf() async {
    final PickType pickType = await Get.dialog<PickType>(
      AlertDialog(
        title: Text('Select Source'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text('Images from Camera'),
                onTap: () => Get.back(result: PickType.camera),
              ),
              SizedBox(height: 16),
              GestureDetector(
                child: Text('Images from Gallery'),
                onTap: () => Get.back(result: PickType.gallery),
              ),
              SizedBox(height: 16),
              GestureDetector(
                child: Text('PDF Files'),
                onTap: () => Get.back(result: PickType.file),
              ),
            ],
          ),
        ),
      ),
    );

    if (pickType != null && pickType != PickType.file) {
      final pickedFile = await ImagePicker().getImage(
          source: pickType == PickType.camera
              ? ImageSource.camera
              : ImageSource.gallery);
      if (pickedFile != null) {
        return File(pickedFile.path);
      } else {
        print('No image selected.');
        return null;
      }
    } else if (pickType == PickType.file) {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        return File(result.files.first.path);
      }
    }

    return null;
  }
}

enum PickType { camera, gallery, file }
