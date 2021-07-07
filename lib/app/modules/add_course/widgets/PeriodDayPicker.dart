import 'package:ajent/core/values/colors.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class PeriodDayPicker extends StatelessWidget {

  PeriodDayPicker({void Function(int) onAddButtonPress})
  {
    this.onAddButtonPress = onAddButtonPress;
  }

  int index;
  void Function(int) onAddButtonPress;
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
            child: Column(
              children: [
                TabBar(
                  onTap: (index) {
                    this.index = index;
                  },
                  unselectedLabelColor: Colors.black,
                  unselectedLabelStyle: TextStyle(fontSize: 10.5),
                  labelColor: Colors.black,
                  labelStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  indicator: BubbleTabIndicator(
                    //indicatorHeight: 30.0,
                    indicatorColor: primaryColor,
                    tabBarIndicatorSize: TabBarIndicatorSize.label,
                    insets: const EdgeInsets.symmetric(horizontal: 2.0),
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: -6.0),
                  ),
                  tabs: [
                    Text("day_2".tr),
                    Text("day_3".tr),
                    Text("day_4".tr),
                    Text("day_5".tr),
                    Text("day_6".tr),
                    Text("day_7".tr),
                    Text("day_1".tr),
                  ],
                ),
                SizedBox(
                  height: 60,
                  child: TabBarView(
                    children: [
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          onAddButtonPress(index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          onAddButtonPress(index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          onAddButtonPress(index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          onAddButtonPress(index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          onAddButtonPress(index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          onAddButtonPress(index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          onAddButtonPress(index);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),

      ],
    );
  }
}
