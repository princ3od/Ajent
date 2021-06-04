import 'package:ajent/app/data/models/AjentUser.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

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
    timeDilation = 1.0;
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
}
