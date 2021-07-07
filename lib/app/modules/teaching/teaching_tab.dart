import 'package:ajent/app/global_widgets/teaching_card.dart';
import 'package:ajent/app/modules/teaching/teaching_controller.dart';
import 'package:ajent/app/modules/teaching/widgets/empty_teaching.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TeachingTab extends StatelessWidget {
  final TeachingController controller = Get.find<TeachingController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        DefaultTabController(
          initialIndex: controller.currentIndex.value,
          length: 3,
          child: TabBar(
              onTap: controller.onTabChanged,
              unselectedLabelColor: Colors.black,
              indicator: BubbleTabIndicator(
                //indicatorHeight: 30.0,
                indicatorColor: Colors.black,
                tabBarIndicatorSize: TabBarIndicatorSize.label,
                insets: const EdgeInsets.symmetric(horizontal: 2.0),
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: -8.0),
              ),
              tabs: [
                Tab(text: "Taught".tr),
                Tab(text: "Current teaching".tr),
                Tab(text: "Waiting".tr),
              ]),
        ),
        Flexible(
          child: Obx(
            () => SmartRefresher(
              physics: BouncingScrollPhysics(),
              controller: controller.refreshController,
              onRefresh: () async {
                await controller.fetchCourses();
              },
              child: (controller.courses?.length == 0)
                  ? AnimatedOpacity(
                      opacity: (controller.courses.length > 0 ||
                              controller.isFetching.value)
                          ? 0
                          : 1,
                      duration: Duration(milliseconds: 500),
                      child: Center(
                        child: EmptyTeaching(
                          index: controller.currentIndex.value,
                        ),
                      ),
                    )
                  : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.courses.length,
                      itemBuilder: (context, index) {
                        return TeachingCard(
                          course: controller.courses[index],
                        );
                      },
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
