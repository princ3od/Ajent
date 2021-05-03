import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/app/modules/home/home_page.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
