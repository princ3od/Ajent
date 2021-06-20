import 'package:get/get.dart';
import 'texting_controller.dart';

class TextingBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut<TextingController>(() => TextingController());
  }
}
