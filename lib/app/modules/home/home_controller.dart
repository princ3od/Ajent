import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var tabpageIndex = 0.obs;
  var isOnMain = true.obs;
  PageController pageController = PageController();
  PageController homePageController = PageController(initialPage: 1);
  @override
  onInit() {
    super.onInit();
  }

  onPageChanged(int index) {
    tabpageIndex.value = index;
  }

  onHomePageChange(int index) {
    isOnMain.value = (index == 1);
  }
}
