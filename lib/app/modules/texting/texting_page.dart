import 'package:ajent/app/modules/texting/widgets/chat_group_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'texting_controller.dart';

class TextingPage extends StatelessWidget {
  final TextingController controller = Get.find<TextingController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'texting'.tr,
          style: GoogleFonts.nunitoSans(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Obx(
            () => AnimatedOpacity(
              opacity: (controller.isLoadingGroup.value)
                  ? 0
                  : (controller.chatGroups.length > 0)
                      ? 0
                      : 1,
              duration: Duration(milliseconds: 500),
              child: IgnorePointer(
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: Get.width - 60,
                                maxHeight: Get.width - 20,
                              ),
                              child: Image.asset(
                                'assets/images/empty_conversation.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              'You have no conversations.'.tr,
                              style: GoogleFonts.nunitoSans(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "All your conversations you made appeear here."
                                  .tr,
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
          Column(
            children: [
              SizedBox(height: 10),
              Obx(() => Expanded(
                    child: SmartRefresher(
                      physics: BouncingScrollPhysics(),
                      controller: controller.refreshController,
                      onRefresh: () async {
                        await controller.fetchChatGroup();
                      },
                      child: ListView.builder(
                        itemCount: controller.chatGroups.length +
                            ((controller.isLoadingGroup.value) ? 2 : 0),
                        itemBuilder: (context, index) {
                          if (index > controller.chatGroups.length - 1)
                            return ListTileShimmer();
                          return ChatGroupItem(
                            chatGroup: controller.chatGroups[index],
                            index: index,
                          );
                        },
                      ),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
