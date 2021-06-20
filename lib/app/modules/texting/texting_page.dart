import 'package:ajent/app/modules/texting/widgets/chat_group_item.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'texting_controller.dart';

class TextingPage extends StatelessWidget {
  final TextingController controller = Get.find<TextingController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        toolbarHeight: 70.0,
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
        actions: [
          IconButton(
              icon: Icon(
                Icons.add_circle,
                color: Colors.black,
                size: 24,
              ),
              onPressed: () {}),
        ],
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
                            'You have no conversations.',
                            style: GoogleFonts.nunitoSans(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "All your conversations you made appeear here.",
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
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: TextField(
                  autofocus: false,
                  decoration: searchTextfieldDecoration,
                ),
              ),
              Obx(
                () => (!controller.isLoadingGroup.value)
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: controller.chatGroups.length,
                          itemBuilder: (context, index) {
                            return ChatGroupItem(
                              chatGroup: controller.chatGroups[index],
                              partner: controller.chatGroups[index].partner,
                              index: index,
                            );
                          },
                        ),
                      )
                    : Expanded(
                        child: Center(child: CircularProgressIndicator())),
              ),
            ],
          ),
        ],
      ),
    );
  }
}