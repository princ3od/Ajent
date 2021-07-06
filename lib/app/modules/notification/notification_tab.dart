import 'package:ajent/app/data/services/notification_service.dart';
import 'package:ajent/app/modules/notification/notification_controller.dart';
import 'package:ajent/app/modules/notification/widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationTab extends StatelessWidget {
  final NotificationController controller = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
      child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.fromLTRB(0,10,0,0),
            child: Text(
              'notification'.tr,
              style: GoogleFonts.nunitoSans(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: Obx(
              () => SmartRefresher(
                physics: BouncingScrollPhysics(),
                controller: controller.refreshController,
                onRefresh: () async {
                  await controller.fetch();
                },
                child: (controller.notifications.length > 0)
                    ? ListView.builder(
                        itemCount: controller.notifications.length,
                        itemBuilder: (context, index) {
                          return NotificationItem(
                            notificationData: controller.notifications[index],
                            onDelete: () async {
                              await NotificationService.instance
                                  .deleteNotification(
                                      controller.notifications[index].id);
                              controller.fetch();
                            },
                            onOpen: () {
                              controller.open(controller.notifications[index]);
                            },
                          );
                        },
                      )
                    : AnimatedOpacity(
                        opacity: (controller.notifications.length > 0 ||
                                controller.isLoading.value)
                            ? 0
                            : 1,
                        duration: Duration(milliseconds: 500),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: Get.width - 100,
                                        maxHeight: Get.width - 100,
                                      ),
                                      child: Image.asset(
                                        'assets/images/empty_notification.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Yay! Your notification is clear. 😗'.tr,
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "All of your notification will appear here.".tr,
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: SizedBox(),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
