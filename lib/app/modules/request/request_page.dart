import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/app/modules/request/request_controller.dart';
import 'package:ajent/app/modules/request/widgets/request_card.dart';
import 'package:ajent/app/modules/request/widgets/request_status_card.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestPage extends StatelessWidget {
  final RequestController controller = Get.put(RequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Tất cả yêu cầu',
          style: GoogleFonts.nunitoSans(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: DefaultTabController(
              initialIndex: controller.tabIndex.value,
              length: 2,
              child: TabBar(
                  onTap: (value) async {
                    controller.tabIndex.value = value;
                    if (value == 0 && controller.isLoading.value == true) {
                      await controller.getRequestItems();
                    }
                  },
                  unselectedLabelColor: Colors.black,
                  indicator: BubbleTabIndicator(
                    //indicatorHeight: 30.0,
                    indicatorColor: Colors.black,
                    tabBarIndicatorSize: TabBarIndicatorSize.label,
                    insets: const EdgeInsets.symmetric(horizontal: 2.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: -8.0),
                  ),
                  tabs: [
                    Tab(text: "Từ người khác"),
                    Tab(text: "Của bạn"),
                  ]),
            ),
          ),
          Obx(
            () => SingleChildScrollView(
              child: Column(
                children: [
                  if (controller.tabIndex.value == 0)
                    Container(
                        height: Get.height - 168,
                        child: Obx(() => (controller.isLoading.value == true)
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                itemCount: controller.requestItems.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  return RequestCard(
                                      onApprovePressed: (value) async {
                                        await controller
                                            .onApproveButtonPress(value);
                                      },
                                      request: controller
                                          .requestItems[index].request,
                                      star: controller.requestItems[index].star,
                                      requestor: controller
                                          .requestItems[index].requestor,
                                      course:
                                          controller.requestItems[index].course,
                                      onDeniedPressed: (value) async {
                                        await controller
                                            .onDeniedButtonPress(value);
                                      });
                                })))
                  else
                    Container(
                      height: Get.height - 168,
                      child: Obx(
                        () => controller.isLoadingStatus.value == true
                            ? Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                itemCount: controller.requestStatusItems.length,
                                itemBuilder: (context, index) {
                                  return RequestStatusCard(
                                    course: controller
                                        .requestStatusItems[index].course,
                                    request: controller
                                        .requestStatusItems[index].request,
                                  );
                                },
                              ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
