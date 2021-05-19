import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ajent/app/modules/auth/auth_controller.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import '../home/widgets/HomeTab.dart';
import '../home/widgets/LearningTab.dart';
import '../home/widgets/TeachingTab.dart';
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
                                onPressed: () {},
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                            onPressed: () {
                              Get.put<AuthController>(AuthController())
                                  .signOutGoogle();
                            },
                            child: Text("Đăng xuất"))),
                    SizedBox(height: 5),
                    Text("Ajent"),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(() => (controller.isOnMain.value)
          ? BottomNavigationBar(
              onTap: (index) {
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
                    activeIcon: Icon(Icons.home_filled)),
                BottomNavigationBarItem(
                  label: "Học tập",
                  icon: Icon(Icons.school),
                ),
                BottomNavigationBarItem(
                  label: "Giảng dạy",
                  icon: Icon(Icons.history_edu),
                ),
                BottomNavigationBarItem(
                  label: "Thông báo",
                  icon: Icon(Icons.notifications),
                ),
              ],
            )
          : Container(height: 0)),
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
      body: PageView(
        scrollDirection: Axis.vertical,
        controller: controller.homePageController,
        onPageChanged: controller.onHomePageChange,
        children: <Widget>[
          HomeBackground(),
          Padding(
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
                )),
          ),
        ],
      ),
    );
  }
}
