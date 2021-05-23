import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ajent/app/modules/auth/auth_controller.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../home/widgets/HomeTab.dart';
import '../learning/learning_tab.dart';
import '../teaching/teaching_tab.dart';
import '../home/widgets/NotificationTab.dart';
import '../home/widgets/HomeBackground.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 70,
                        height: 70,
                        child: Image.asset("assets/images/demo.png"),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Text(
                            "Duong Binh Trong",
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 12.0, left: 4.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: OutlinedButton(
                                onPressed: () {
                                  Get.toNamed(Routes.PROFILE);
                                },
                                child: Text("Thông tin cá nhân"),
                                style: outlinedButtonStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextButton(onPressed: () {}, child: Text("Lịch sử"))),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextButton(onPressed: () {}, child: Text("Cài đặt"))),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextButton(
                      onPressed: () {}, child: Text("Quy định & chính sách"))),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 5),
                          child: OutlinedButton(
                              onPressed: () {
                                Get.put<AuthController>(AuthController())
                                    .signOutGoogle();
                              },
                              child: Text(
                                "Đăng xuất",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600),
                              ),
                              style: OutlinedButton.styleFrom(
                                primary: Colors.red,
                                onSurface: primaryColor,
                                padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                                side: BorderSide(color: Colors.red, width: 1.6),
                              )),
                        )),
                    SizedBox(height: 5),
                    Text("© Ajent"),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            onTap: (index) async {
              controller.tabpageIndex.value = index;
              controller.pageController.animateToPage(
                controller.tabpageIndex.value,
                duration: Duration(milliseconds: 500),
                curve: Curves.fastLinearToSlowEaseIn,
              );
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
      body: SlidingUpPanel(
        controller: controller.panelController,
        defaultPanelState: PanelState.OPEN,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        maxHeight: Get.height - 15 - kBottomNavigationBarHeight,
        minHeight: Get.height / 5,
        header: SizedBox(
          width: Get.width,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                width: 100,
                height: 3.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.5),
                  color: Colors.grey.withAlpha(125),
                ),
              ),
            ),
          ),
        ),
        body: HomeBackground(),
        panel: Padding(
          padding: const EdgeInsets.only(top: 15),
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
              onPageChanged: controller.onPageChanged,
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
      ),
    );
  }
}
