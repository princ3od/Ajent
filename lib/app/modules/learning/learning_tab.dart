import 'package:ajent/app/data/models/Course.dart';
import 'package:ajent/app/global_widgets/course_card.dart';
import 'package:ajent/app/modules/learning/learning_controlller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

class LearningTab extends StatelessWidget {
  final LearningController controller =
      Get.put<LearningController>(LearningController());
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        DefaultTabController(
          initialIndex: 1,
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
            () => ListView.builder(
              itemCount: controller.courses.length,
              itemBuilder: (context, index) {
                return CourseCard(
                  course: controller.courses[index],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
