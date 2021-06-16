import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/services/user_service.dart';
import 'package:get/get.dart';

class ProfileViewController extends GetxController {
  var averageStar = (-2.0).obs;
  @override
  void onInit() async {
    super.onInit();
    AjentUser user = Get.arguments;
    averageStar.value =
        await UserService.instance.getAverageEvaluationStar(user.uid);
  }
}
