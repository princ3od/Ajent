import 'package:get/get.dart';
import 'my_profile_controller.dart';

class MyProfileBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut<MyProfileController>(() => MyProfileController());
  }
}
