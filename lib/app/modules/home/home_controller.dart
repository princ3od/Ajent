import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeController extends GetxController {
  var tabpageIndex = 0.obs;
  var isOnMain = true.obs;
  var childTabIndex = 0.obs;
  PageController pageController = PageController();
  PanelController panelController = PanelController();
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
    tabpageIndex.value = index;
  }
}
