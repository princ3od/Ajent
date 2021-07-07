import 'package:ajent/app/data/services/notification_service.dart';
import 'package:ajent/app/data/services/subscribe_service.dart';
import 'package:ajent/routes/pages.dart';
import 'package:ajent/app/data/models/Request.dart';
import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/models/requestCardData.dart';
import 'package:ajent/app/data/models/requestStatusCardData.dart';
import 'package:ajent/app/data/services/request_service.dart';
import 'package:ajent/app/data/services/user_service.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:get/get.dart';

class RequestController extends GetxController {
  RequestService requestService = RequestService.instance;
  var ajentUser = HomeController.mainUser;
  var tabIndex = 0.obs;
  var isLoading = true.obs;

  // ignore: deprecated_member_use
  var requestItems = List<RequestCardData>();

  Future<void> getRequestItems() async {
    requestItems = await requestService.getRequestItems(ajentUser.uid);
    isLoading.value = false;
  }

  Future<void> onDeniedButtonPress(RequestCardData requestItem) async {
    var result = await requestService.onDeniedButtonPress(requestItem.request);
    if (result) {
      isLoading.value = true;
      await NotificationService.instance
          .notifyDenyRequest(requestItem.course, requestItem.request);
      await getRequestItems();
    } else {
      Get.snackbar("Warning".tr, "Update failed".tr);
    }
  }

  Future<void> onApproveButtonPress(RequestCardData requestItem) async {
    var result = await requestService.onApproveButtonPress(requestItem.request);
    await NotificationService.instance
        .notifyApproveCourse(requestItem.course, requestItem.request);
    if (result) {
      isLoading.value = true;
      await getRequestItems();
    } else {
      Get.snackbar("Warning".tr, "Update failed".tr);
    }
  }

  var isLoadingStatus = true.obs;
  // ignore: deprecated_member_use
  var requestStatusItems = List<RequestStatusCardData>();
  Future<void> getRequestStatusItems() async {
    requestStatusItems =
        await requestService.getRequestStatusItems(ajentUser.uid);
    isLoadingStatus.value = false;
  }

  Future<void> onStatusDenied(RequestStatusCardData item) async {
    bool result = await requestService.delRequest(item.request);
    await NotificationService.instance
        .notifyCancelRequest(item.course, HomeController.mainUser);
    await SubscribeService.instance
        .unsubscribeOnCanelRequest(item.course.id, item.request.id);
    if (result) {
      Get.snackbar("Success".tr, "Request canceled".tr);
      isLoadingStatus.value = true;
      getRequestStatusItems();
    } else {
      Get.snackbar("Warning".tr, "Server is busy, please try again later".tr);
    }
  }

  Future<void> onStatusContact(Request item) async {
    AjentUser user = await UserService.instance.getUser(item.receiverUid);
    Get.toNamed(Routes.CHATTING, arguments: user);
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await getRequestStatusItems();
    await getRequestItems();
  }
}
