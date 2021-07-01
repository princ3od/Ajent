import 'package:ajent/app/data/models/requestCardData.dart';
import 'package:ajent/app/data/services/request_service.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:get/get.dart';

class RequestController extends GetxController {
  RequestService requestService = RequestService.instance;
  var ajentUser = HomeController.mainUser;
  var tabIndex = 0.obs;
  // ignore: deprecated_member_use
  var requestItems = List<RequestCardData>().obs;

  Future<void> getRequestItems() async {
    requestItems.value = await requestService.getRequestItems(ajentUser.uid);
    print("object");
  }

  @override
  Future<void> onInit() async {
    super.onInit();
   await getRequestItems();
  }
}
