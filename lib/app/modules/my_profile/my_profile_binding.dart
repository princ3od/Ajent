import 'package:get/get.dart';
import 'my_profile_controller.dart';

class MyProfileBinding implements Bindings {
  @override
  void dependencies() {
    print("binding");
    Get.lazyPut<MyProfileController>(() => MyProfileController());
  }
//
}
