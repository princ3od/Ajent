import 'package:ajent/app/global_widgets/course_card.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/app/modules/home/widgets/calendar_child_tab.dart';
import 'package:ajent/app/modules/home/widgets/suggestion_child_tab.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeTab extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: TabBar(
              onTap: controller.oncChildTabChanged,
              unselectedLabelColor: Colors.black,
              indicator: BubbleTabIndicator(
                //indicatorHeight: 30.0,
                indicatorColor: Colors.black,
                tabBarIndicatorSize: TabBarIndicatorSize.label,
                insets: const EdgeInsets.symmetric(horizontal: 2.0),
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: -24.0),
              ),
              tabs: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 5),
                    Text("Lịch"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 5),
                    Text("Dành cho tôi"),
                  ],
                ),
              ]),
        ),
        Obx(() => (controller.childTabIndex.value == 0)
            ? Expanded(child: CalendarChildTab())
            : SuggestionChildTab()),
      ],
    );
  }
}
