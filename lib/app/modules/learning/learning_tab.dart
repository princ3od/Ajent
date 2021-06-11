import 'package:ajent/app/global_widgets/course_card.dart';
import 'package:ajent/app/modules/learning/learning_controlller.dart';
import 'package:ajent/app/modules/learning/widgets/empty_learning.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LearningTab extends StatelessWidget {
  final LearningController controller =
      Get.put<LearningController>(LearningController());
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
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
                Tab(text: "Đã học"),
                Tab(text: "Đang học"),
                Tab(text: "Đang chờ"),
              ]),
        ),
        Flexible(
          child: Obx(
            () => (controller.courses.length <= 0)
                ? EmptyLearning(
                    index: controller.currentIndex.value,
                  )
                : SmartRefresher(
                    physics: BouncingScrollPhysics(),
                    controller: controller.refreshController,
                    onRefresh: () async {
                      await controller.fetchCourses();
                    },
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.courses.length,
                      itemBuilder: (context, index) {
                        return CourseCard(
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
