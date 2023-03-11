import 'dart:io';

import 'package:ajent/app/data/services/storage_service.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/core/utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../data/models/resource.dart';
import '../../data/services/resource_service.dart';

class ResoucesController extends GetxController {
  var refreshController = RefreshController();

  var resouces = <Resource>[].obs;
  var isUploading = false.obs;
  var isLoading = false.obs;
  var hasFile = false.obs;

  File file;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchResources();
  }

  fetchResources() async {
    isLoading.value = true;
    resouces.value = await ResourceService.instance
        .getResourcesOfUser(HomeController.mainUser.uid);
    refreshController.refreshCompleted();
    isLoading.value = false;
  }

  pickFile() async {
    hasFile.value = false;
    file = await FileUtilitiy.pickImageOrPdf();
    hasFile.value = file != null;
  }

  upload(BuildContext context) async {
    if (isUploading.value) return;
    if (file == null) {
      Get.snackbar('Error', 'Please choose a file');

      return;
    }
    if (nameController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter title');
      return;
    }
    isUploading.value = true;
    final url = await StorageService.instance.uploadResource(file);
    final resource = Resource(
      name: nameController.text,
      description: descriptionController.text,
      url: url,
      createdAt: DateTime.now(),
      owner: HomeController.mainUser.uid,
      type: file.path.split('.').last,
    );
    final result = await ResourceService.instance.createResouce(resource);
    Get.find<HomeController>().uploadedCount.value++;
    Get.find<HomeController>().totalTutoringHours.value++;
    resouces.insert(0, result);
    isUploading.value = false;
    Navigator.maybePop(context);
    Get.snackbar('Success', 'Upload resource successfully');
  }
}
