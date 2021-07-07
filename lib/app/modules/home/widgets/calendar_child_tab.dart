import 'package:ajent/app/data/services/notification_service.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/app/modules/home/widgets/calendar_content/study_calendar_event.dart';
import 'package:ajent/app/modules/home/widgets/calendar_content/teaching_calendar_event.dart';
import 'package:ajent/core/utils/date_converter.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CalendarChildTab extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(
          () => AnimatedOpacity(
            opacity: (controller.isFetching.value &&
                    !controller.refreshController.isRefresh)
                ? 1
                : 0,
            duration: Duration(milliseconds: 500),
            child: Container(
              height: Get.height - kBottomNavigationBarHeight,
              child: Center(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        ),
        Column(
          children: [
            SizedBox(height: 10),
            DefaultTabController(
              initialIndex: controller.weekTabIndex.value,
              length: 7,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                child: TabBar(
                  physics: BouncingScrollPhysics(),
                  isScrollable: true,
                  onTap: (index) {
                    controller.weekTabIndex.value = index;
                    controller.loadCourses();
                  },
                  unselectedLabelColor: Colors.black,
                  unselectedLabelStyle: TextStyle(fontSize: 12),
                  labelColor: Colors.black,
                  labelStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  indicator: BubbleTabIndicator(
                    indicatorHeight: 10.0,
                    indicatorRadius: 40.0,
                    indicatorColor: primaryColor,
                    tabBarIndicatorSize: TabBarIndicatorSize.label,
                    insets: const EdgeInsets.symmetric(horizontal: 2.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: -1.0),
                  ),
                  tabs: [
                    for (var day in DateConverter.weekDays()) Tab(text: day),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Obx(
                () => SmartRefresher(
                  physics: BouncingScrollPhysics(),
                  controller: controller.refreshController,
                  onRefresh: () async {
                    await controller.fetch();
                  },
                  child: (controller.courses?.length == 0)
                      ? AnimatedOpacity(
                          opacity: (controller.courses.length > 0 ||
                                  controller.isFetching.value)
                              ? 0
                              : 1,
                          duration: Duration(milliseconds: 500),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxWidth: Get.width - 80,
                                          maxHeight: Get.width - 80,
                                        ),
                                        child: Image.asset(
                                          'assets/images/break_day.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'A break-day! 🤩'.tr,
                                        style: GoogleFonts.nunitoSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Enjoy yourself, have a nice day".tr,
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
                        )
                      : SingleChildScrollView(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: controller.courses.length,
                            itemBuilder: (context, index) {
                              if (controller.courses[index].teacher ==
                                  HomeController.mainUser.uid) {
                                return TeachingCalendarEventCard(
                                    course: controller.courses[index]);
                              }
                              return StudyCalendarEventCard(
                                  course: controller.courses[index]);
                            },
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
