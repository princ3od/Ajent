import 'package:ajent/app/data/services/notification_service.dart';
import 'package:ajent/app/modules/notification/notification_controller.dart';
import 'package:ajent/app/modules/notification/widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationTab extends StatelessWidget {
  NotificationController controller = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
      child: Column(
        children: [
          Flexible(
            child: Obx(
              () => SmartRefresher(
                physics: BouncingScrollPhysics(),
                controller: controller.refreshController,
                onRefresh: () async {
                  await controller.fetch();
                },
                child: ListView.builder(
                  itemCount: controller.notifications.length,
                  itemBuilder: (context, index) {
                    return NotificationItem(
                      notificationData: controller.notifications[index],
                      onDelete: () async {
                        await NotificationService.instance.deleteNotification(
                            controller.notifications[index].id);
                        controller.fetch();
                      },
                      onOpen: () {
                        controller.open(controller.notifications[index]);
                      },
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
