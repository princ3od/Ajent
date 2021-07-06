import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'my_teaching_detail_controller.dart';

class MyTeachingDetailPage extends StatelessWidget {
  final Course course = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final MyTeachingDetailController controller =
        Get.put(MyTeachingDetailController(course));

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Course detail".tr,
            //course.name,
            overflow: TextOverflow.fade,
            style: GoogleFonts.nunitoSans(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.grey[100],
          toolbarHeight: 70,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
            onPressed: () => Get.back(),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.share,
                  color: Colors.black,
                ),
                onPressed: () {}),
            Obx(
              () => Visibility(
                visible: controller.editable.value,
                child: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    onPressed: () {}),
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Center(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Hero(
                        tag: '${course.id} avatar',
                        child: CircleAvatar(
                          child: ClipOval(
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/ajent_logo.png',
                              image: course.photoUrl,
                              width: 100,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          radius: 40.0,
                        ),
                      ),
                    ),
                    Hero(
                      tag: '${course.id} name',
                      child: Material(
                        color: Colors.transparent,
                        child: SizedBox(
                          width: Get.width - 120,
                          child: Text(
                            course.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w700, fontSize: 14),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Obx(
                  () => (controller.isLoading.value)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Scrollbar(
                          isAlwaysShown: true,
                          thickness: 4,
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Course ID".tr,
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                    child: TextFormField(
                                      initialValue: course.id.toUpperCase(),
                                      decoration: primaryTextFieldDecoration,
                                      cursorColor: primaryColor,
                                      readOnly: true,
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                    ),
                                  ),
                                  // Text("Họ và tên giảng viên",
                                  //     style: GoogleFonts.nunitoSans(
                                  //         fontWeight: FontWeight.bold, fontSize: 12)),
                                  // Padding(
                                  //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                  //   child: TextFormField(
                                  //     onTap: () {
                                  //       print('teacher details');
                                  //     },
                                  //     initialValue:
                                  //         'Trần Văn A', //Get a link here to get to teacher profile page
                                  //     decoration: primaryTextFieldDecoration,
                                  //     cursorColor: primaryColor,
                                  //     readOnly: true,
                                  //     style: GoogleFonts.nunitoSans(
                                  //         color: primaryColor,
                                  //         fontWeight: FontWeight.w600,
                                  //         fontSize: 12),
                                  //   ),
                                  // ),
                                  Text("Address".tr,
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                    child: TextFormField(
                                      onTap: () {
                                        launch(
                                            'https://www.google.com/maps/search/?api=1&query=${course.address}');
                                      },
                                      initialValue: course
                                          .address, //Get a link here to get to google maps.
                                      decoration: primaryTextFieldDecoration,
                                      cursorColor: primaryColor,
                                      readOnly: true,
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  Text("Study time".tr,
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                  TextFormField(
                                    initialValue: controller.course?.value
                                            ?.getTimeAsString() ??
                                        "",
                                    decoration: primaryTextFieldDecoration,
                                    cursorColor: primaryColor,
                                    readOnly: true,
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                  SizedBox(height: 8),
                                  Text('tuition_label'.tr,
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                  TextFormField(
                                    initialValue: NumberFormat.currency(
                                            locale: "vi_VN", symbol: "VNĐ")
                                        .format(
                                            controller.course?.value?.price ??
                                                0),
                                    decoration: primaryTextFieldDecoration,
                                    cursorColor: primaryColor,
                                    readOnly: true,
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                  SizedBox(height: 8),
                                  Text('number_of_student_label'.tr,
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                  TextFormField(
                                    initialValue: controller.learners.length
                                            .toString() +
                                        " (Max: ${controller.course.value.maxLearner})",
                                    decoration: primaryTextFieldDecoration,
                                    cursorColor: primaryColor,
                                    readOnly: true,
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                  SizedBox(height: 8),
                                  Text("Students' information".tr,
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                  TextFormField(
                                    initialValue: controller.getLearners(),
                                    decoration: primaryTextFieldDecoration,
                                    cursorColor: primaryColor,
                                    readOnly: true,
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Align(
                                      alignment: FractionalOffset.bottomCenter,
                                      child: Center(
                                          child: Text("© Ajent ",
                                              style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.w100,
                                                  fontSize: 12))),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
              ),
              Obx(
                () => (controller.joinable.value)
                    ? Visibility(
                        visible: MediaQuery.of(context).viewInsets.bottom == 0,
                        child: Container(
                          height: kBottomNavigationBarHeight + 15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  if (controller.joinable.value)
                                    ElevatedButton(
                                      onPressed: () {
                                        //
                                      },
                                      style: orangeButtonStyle,
                                      child: (controller.isJoining.value)
                                          ? SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.white),
                                              ),
                                            )
                                          : Text("Join".tr,
                                              style: GoogleFonts.nunitoSans(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700)),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(),
              ),
            ],
          ),
        ));
  }
}
