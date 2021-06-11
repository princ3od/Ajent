import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:get/get.dart';
import 'my_profile_controller.dart';

class MyProfileBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    print("binding");
    MyProfileController controller = MyProfileController();
    Get.lazyPut<MyProfileController>(() => controller);
    controller.degrees.value =
        await controller.userService.getDegrees(HomeController.mainUser.uid);
        controller.students.value = await
    controller.userService.getStudents(HomeController.mainUser.uid);
  }
}
