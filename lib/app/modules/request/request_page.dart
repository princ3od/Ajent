import 'package:ajent/app/data/models/Request.dart';
import 'package:ajent/app/data/services/request_service.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/app/modules/request/request_controller.dart';
import 'package:ajent/app/modules/request/widgets/empty_request.dart';
import 'package:ajent/app/modules/request/widgets/request_card.dart';
import 'package:ajent/app/modules/request/widgets/request_status_card.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final RequestController controller = Get.put(RequestController());

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    controller.isLoadingStatus.value = true;
    await controller.getRequestStatusItems();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'All requests'.tr,
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
                    Tab(text: "From others".tr),
                    Tab(text: "Yours".tr),
                  ]),
            ),
          ),
          Expanded(
            child: Obx(
              () => (controller.tabIndex.value == 0)
                  ? Obx(() => (controller.isLoading.value == true)
                      ? Center(
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : (controller.requestItems.length == 0)
                          ? AnimatedOpacity(
                              opacity: (controller.requestItems.length > 0 ||
                                      controller.isLoading.value)
                                  ? 0
                                  : 1,
                              duration: Duration(milliseconds: 500),
                              child: Center(
                                child: EmptyRequest(
                                  index: controller.tabIndex.value,
                                ),
                              ),
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
                                    data: controller.requestItems[index],
                                    onDeniedPressed: (value) async {
                                      await controller
                                          .onDeniedButtonPress(value);
                                    });
                              }))
                  : Obx(
                      () => controller.isLoadingStatus.value == true
                          ? Center(child: CircularProgressIndicator())
                          : SmartRefresher(
                              controller: _refreshController,
                              onRefresh: _onRefresh,
                              onLoading: _onLoading,
                              child: (controller.requestItems.length == 0)
                                  ? AnimatedOpacity(
                                      opacity: (controller.requestStatusItems
                                                      .length >
                                                  0 ||
                                              controller.isLoading.value)
                                          ? 0
                                          : 1,
                                      duration: Duration(milliseconds: 500),
                                      child: Center(
                                        child: EmptyRequest(
                                          index: controller.tabIndex.value,
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          controller.requestStatusItems.length,
                                      itemBuilder: (context, index) {
                                        return RequestStatusCard(
                                          data: controller
                                              .requestStatusItems[index],
                                          onDenied: (value) {
                                            controller.onStatusDenied(value);
                                          },
                                          onContact: (value) {
                                            controller.onStatusContact(value);
                                          },
                                        );
                                      },
                                    ),
                            ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
