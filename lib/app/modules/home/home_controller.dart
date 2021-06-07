import 'package:ajent/app/data/models/AjentUser.dart';
import 'package:ajent/routes/pages.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeController extends GetxController {
  var tabpageIndex = 0.obs;
  var isOnMain = true.obs;
  var childTabIndex = 0.obs;
  var targetPage = 0;
  var needChangeNavigator = true;
  PageController pageController = PageController();
  PanelController panelController = PanelController();
  static AjentUser mainUser;
  @override
  onInit() {
    super.onInit();
  }

  oncChildTabChanged(int index) {
    childTabIndex.value = index;
  }

  onPageChanged(int index) {
    if (!panelController.isPanelOpen) {
      panelController.open();
    }
    if (index == targetPage && needChangeNavigator) {
      tabpageIndex.value = index;
    }
  }

  static checkUserUpdateInfo() {
    if (!HomeController.mainUser.isInfoUpdated()) {
      print("cc");
      Get.dialog(AlertDialog(
        title: Text("Cập nhật thông tin"),
        content: Text(
            "Vui lòng cập nhật thông tin để có thể bắt đầu sử dụng toàn bộ tính năng Ajent."),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
                Get.toNamed(Routes.PROFILE);
              },
              child: Text("CẬP NHẬT")),
        ],
      ));
    }
  }
}
