import 'dart:ffi';

import 'package:ajent/app/data/models/Request.dart';
import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/models/evaluation.dart';
import 'package:ajent/app/data/models/requestCardData.dart';
import 'package:ajent/app/data/models/requestStatusCardData.dart';
import 'package:ajent/app/data/services/course_service.dart';
import 'package:ajent/app/data/services/request_service.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestController extends GetxController {
  RequestService requestService = RequestService.instance;
  var ajentUser = HomeController.mainUser;
  var tabIndex = 0.obs;
  var isLoading = true.obs;

  // ignore: deprecated_member_use
  var requestItems = List<RequestCardData>();

  Future<void> getRequestItems() async {
    requestItems = await requestService.getRequestItems(ajentUser.uid);
    isLoading.value = false;
    Get.snackbar("Thông báo", "Dữ liệu mới đã được cập nhật");
  }

  Future<void> onDeniedButtonPress(Request requestItem) async {
    var result = await requestService.onDeniedButtonPress(requestItem);
    if (result) {
      isLoading.value = true;
      await getRequestItems();
    } else {
      Get.snackbar("Cảnh báo", "Đã cập nhật các yêu cầu thất bại.");
    }
  }

  Future<void> onApproveButtonPress(Request requestItem) async {
    var result = await requestService.onApproveButtonPress(requestItem);
    if (result) {
      isLoading.value = true;
      await getRequestItems();
    } else {
      Get.snackbar("Cảnh báo", "Đã cập nhật các yêu cầu thất bại.");
    }
  }

  var isLoadingStatus = true.obs;
  // ignore: deprecated_member_use
  var requestStatusItems = List<RequestStatusCardData>();
  Future<void> getRequestStatusItems() async {
    requestStatusItems =
        await requestService.getRequestStatusItems(ajentUser.uid);
    isLoadingStatus.value = false;
    Get.snackbar("Thông báo", "Dữ liệu mới đã được cập nhật");
  }

  Future<void> onStatusDenied(Request item) async {
    bool result = await requestService.delRequest(item);
    if (result) {
      Get.snackbar("Thông báo", "Huỷ yêu cầu thành công");
      isLoadingStatus.value = true;
      getRequestStatusItems();
    } else {
      Get.snackbar("Cảnh báo", "Có lỗi xảy ra, vui lòng thử lại sau.");
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await getRequestStatusItems();
    await getRequestItems();
    Get.snackbar("Thông báo", "Hoàn tất đồng bộ hoá dữ liệu");
  }
}
