import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/modules/search/widgets/empty_search.dart';
import 'package:ajent/app/modules/search/widgets/no_result.dart';
import 'package:ajent/app/modules/search/widgets/search_course_card.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'search_screen_controller.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchController controller = Get.put(SearchController());

  final scrollControler = ScrollController();

  @override
  void initState() {
    scrollControler.addListener(() {
      if (scrollControler.position.atEdge) {
        if (scrollControler.position.pixels == 0)
          print('ListView scrolled to top');
        else if (controller.loadMore) {
          if (controller.previousLength != controller.currentLength) {
            print('ListView scrolled to bottom');
            controller.previousLength = controller.currentLength;
            controller.loadMore = true;
          } else {
            setState(() {
              controller.loadMore = false;
              return;
            });
          }
          setState(() {
            controller.length += 10;
            controller.search();
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        toolbarHeight: 55,
        title: TextFormField(
          autofocus: true,
          controller: controller.txtSearch,
          decoration: searchTextfieldDecoration,
          style: GoogleFonts.nunitoSans(fontSize: 14),
          onChanged: (value) {
            setState(() {
              if (value.isEmpty) {
                return;
              }
              controller.resetSearch();
              controller.search();
            });
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            color: Colors.black,
            onPressed: () {
              controller.showFilter(context);
            },
          ),
        ],
      ),
      body: Stack(
        // mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: AnimatedOpacity(
              opacity: (controller.txtSearch.text.isEmpty) ? 1 : 0,
              duration: Duration(milliseconds: 300),
              child: EmptySearch(),
            ),
          ),
          AnimatedOpacity(
            opacity: (controller.txtSearch.text.isEmpty) ? 0 : 1,
            duration: Duration(milliseconds: 280),
            child: StreamBuilder<QuerySnapshot>(
              stream: controller.result,
              builder: (context, snapshot) {
                if (controller.txtSearch.text.isEmpty) {
                  return Container();
                }
                if (!snapshot.hasData) {
                  return Center(
                    child: ListTileShimmer(),
                  );
                }
                if (snapshot.data.docs.length == 0) {
                  return Center(child: NoResult());
                }
                return ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: scrollControler,
                  itemCount: snapshot.data.docs.length +
                      ((snapshot.connectionState == ConnectionState.waiting)
                          ? 2
                          : 0) +
                      ((controller.loadMore) ? 0 : 1),
                  itemBuilder: (context, index) {
                    if (snapshot.data.docs == null) {
                      return Center(child: NoResult());
                    }
                    if (controller.currentLength != snapshot.data.docs.length) {
                      controller.currentLength = snapshot.data.docs.length;
                    }
                    if ((snapshot.connectionState == ConnectionState.waiting) &&
                        index > snapshot.data.docs.length - 1)
                      return ProfileShimmer();
                    if (!controller.loadMore &&
                        index == snapshot.data.docs.length) {
                      return ListTile(
                          title: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text("--End of result--".tr),
                        ),
                      ));
                    }
                    if (index > snapshot.data.docs.length - 1)
                      return SizedBox();
                    Course course = Course.fromJson(
                        snapshot.data.docs[index].id,
                        snapshot.data.docs[index].data());
                    var isFilter = (course.timeType == TimeType.fixedTime &&
                            !controller.fixedTimeFilter.value) ||
                        (course.timeType == TimeType.periodTime &&
                            !controller.flexibleTimeFilter.value) ||
                        (!course.price.isBetween(controller.priceValues.value));
                    if (isFilter) {
                      return SizedBox();
                    }
                    return Listener(
                        onPointerDown: (e) =>
                            FocusManager.instance.primaryFocus.unfocus(),
                        child: SearchCourseCard(course: course));
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

extension Range on int {
  bool isBetween(RangeValues values) {
    return values.start <= this && this <= values.end;
  }
}
