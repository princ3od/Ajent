import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:google_fonts/google_fonts.dart';
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
      floatingActionButton: Obx(() => Visibility(
            visible: (controller.tabpageIndex.value % 3.0 != 0),
            child: FloatingActionButton.extended(
              onPressed: () {
                Get.toNamed(Routes.ADD_COURSE,
                    arguments: controller.tabpageIndex.value);
              },
              tooltip: 'Increment',
              label: Text('Thêm lớp +'),
              //icon: new Icon(Icons.add, size: 40),
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            onTap: controller.onBottomNavigationBarChanged,
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
                size: 30,
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
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w600, fontSize: 12),
              readOnly: true,
              decoration: searchTextfieldDecoration,
              onTap: () => Get.toNamed(Routes.SEARCH),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.chat_rounded,
              color: Colors.black,
              size: 25,
            ),
            onPressed: () {
              Get.toNamed(Routes.TEXTING);
            },
          ),
        ],
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: Container(
          height: Get.height - 25 - kBottomNavigationBarHeight,
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
