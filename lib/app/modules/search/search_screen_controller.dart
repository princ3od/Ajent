import 'package:ajent/app/data/services/course_service.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SearchController extends GetxController {
  TextEditingController txtSearch = TextEditingController();
  int length = 8;
  int currentLength = -1, previousLength = -1;
  bool loadMore = true;
  var fixedTimeFilter = true.obs;
  var flexibleTimeFilter = true.obs;
  var priceValues = RangeValues(100000, 50000000).obs;
  Stream<QuerySnapshot> result;
  List<String> options = [
    "No teacher".tr,
    "Teacher acquired".tr,
  ];
  List<dynamic> tags = [
    "No teacher".tr,
    "Teacher acquired".tr,
  ];
  @override
  onInit() {
    super.onInit();
  }

  search() async {
    result = CourseService.instance.searchCourse(
        keyword: txtSearch.text.trim().toLowerCase(), maxLength: length);
  }

  resetSearch() {
    loadMore = true;
    length = 8;
    currentLength = previousLength = -1;
  }

  showFilter(BuildContext context) {
    FocusManager.instance.primaryFocus.unfocus();
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      )),
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            height: Get.height * 0.35,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Filter'.tr,
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Study time'.tr,
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  Obx(
                    () => Row(
                      children: [
                        SizedBox(width: 10),
                        ChoiceChip(
                          label: Text('fixedTime'.tr),
                          selected: fixedTimeFilter.value,
                          onSelected: (value) => fixedTimeFilter.value = value,
                        ),
                        SizedBox(width: 10),
                        ChoiceChip(
                          label: Text('periodTime'.tr),
                          selected: flexibleTimeFilter.value,
                          onSelected: (value) =>
                              flexibleTimeFilter.value = value,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'tuition_label'.tr,
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                NumberFormat.currency(
                                        locale: "vi_VN", symbol: "vnd")
                                    .format(priceValues.value.start),
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 12, color: Colors.grey)),
                            Text(
                              NumberFormat.currency(
                                      locale: "vi_VN", symbol: "vnd")
                                  .format(priceValues.value.end),
                              style: GoogleFonts.nunitoSans(
                                  fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: Get.width - 40,
                        child: Obx(
                          () => RangeSlider(
                              activeColor: primaryColor,
                              inactiveColor: Colors.grey,
                              labels: RangeLabels(
                                  NumberFormat.currency(
                                          locale: "vi_VN", symbol: "vnd")
                                      .format(priceValues.value.start),
                                  NumberFormat.currency(
                                          locale: "vi_VN", symbol: "vnd")
                                      .format(priceValues.value.end)),
                              divisions: 500,
                              max: 50000000,
                              min: 0,
                              values: priceValues.value,
                              onChanged: (value) {
                                priceValues.value = value;
                              }),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
