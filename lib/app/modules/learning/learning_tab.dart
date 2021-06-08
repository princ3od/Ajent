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
      children: [
        SizedBox(height: 30),
        DefaultTabController(
          initialIndex: 1,
          length: 3,
          child: TabBar(
              onTap: (index) {
                print(index);
              },
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
        CourseCard(),
      ],
    );
  }
}
