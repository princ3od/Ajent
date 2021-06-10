import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ajent/app/modules/home/home_controller.dart';
import 'widgets/home_tab.dart';
import 'widgets/side_menu.dart';
import '../learning/learning_tab.dart';
import '../teaching/teaching_tab.dart';
import '../notification/notification_tab.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      drawer: SideMenu(),
      floatingActionButton: Obx(() => AnimatedOpacity(
            opacity: (controller.tabpageIndex.value == 1 ||
                    controller.tabpageIndex.value == 2)
                ? 1.0
                : 0.0,
            duration: Duration(milliseconds: 300),
            child: FloatingActionButton(
              onPressed: () {},
              tooltip: 'Increment',
              child: new Icon(Icons.add),
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            onTap: (index) async {
              controller.tabpageIndex.value = index;
              controller.needChangeNavigator = false;
              await controller.pageController.animateToPage(
                controller.tabpageIndex.value,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
              controller.targetPage = index;
              controller.needChangeNavigator = true;
            },
            currentIndex: controller.tabpageIndex.value,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                  label: "Trang chủ",
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home_rounded)),
              BottomNavigationBarItem(
                label: "Học tập",
                icon: Icon(Icons.school_outlined),
                activeIcon: Icon(Icons.school_rounded),
              ),
              BottomNavigationBarItem(
                label: "Giảng dạy",
                icon: Icon(Icons.history_edu_outlined),
                activeIcon: Icon(Icons.history_edu_rounded),
              ),
              BottomNavigationBarItem(
                label: "Thông báo",
                icon: Icon(Icons.notifications_outlined),
                activeIcon: Icon(Icons.notifications_rounded),
              ),
            ],
          )),
      appBar: AppBar(
        backgroundColor: primaryColor,
        shadowColor: Colors.transparent,
        leading: Builder(
          builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.black,
                size: 32,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }),
        ),
        title: Container(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: TextField(
              readOnly: true,
              decoration: searchTextfieldDecoration,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.message,
              color: Colors.black,
              size: 28,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: Container(
          height: Get.height - 15 - kBottomNavigationBarHeight,
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: PageView(
            physics: BouncingScrollPhysics(),
            onPageChanged: (index) {
              controller.targetPage = index;
              controller.onPageChanged(index);
            },
            controller: controller.pageController,
            children: [
              HomeTab(),
              LearningTab(),
              TeachingTab(),
              NotificationTab(),
            ],
          ),
        ),
      ),
    );
  }
}
