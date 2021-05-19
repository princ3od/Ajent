import 'package:ajent/app/modules/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    print("binding");
    Get.lazyPut<SplashController>(() => SplashController());
  }
  //
}
