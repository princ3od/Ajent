import 'package:ajent/app/modules/home/calendar_content/study_calendar_event.dart';
import 'package:ajent/app/modules/home/calendar_content/teaching_calendar_event.dart';
import 'package:ajent/app/modules/search/teachable_teaching_card.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';

class CalendarChildTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        DefaultTabController(
          initialIndex: 0,
          length: 7,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
            child: TabBar(
              isScrollable: true,
              onTap: (index) {
                print(index);
              },
              unselectedLabelColor: Colors.black,
              unselectedLabelStyle: TextStyle(fontSize: 12),
              labelColor: Colors.black,
              labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              indicator: BubbleTabIndicator(
                indicatorHeight: 10.0,
                indicatorRadius: 40.0,
                indicatorColor: primaryColor,
                tabBarIndicatorSize: TabBarIndicatorSize.label,
                insets: const EdgeInsets.symmetric(horizontal: 2.0),
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: -6.0),



              ),
              tabs: [
                Text("T2"),
                Text("T3"),
                Text("T4"),
                Text("T5"),
                Text("T6"),
                Text("T7"),
                Text("CN"),
              ],
            ),
          ),
        ),
        StudyCalendarEventCard(),
        TeachingCalendarEventCard()
      ],
    );
  }
}
