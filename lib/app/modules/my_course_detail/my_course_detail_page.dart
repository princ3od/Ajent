import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/modules/my_course_detail/my_course_detail_controller.dart';
import 'package:ajent/app/modules/my_course_detail/widgets/course_overrall.dart';
import 'package:ajent/app/modules/my_course_detail/widgets/course_personnel.dart';
import 'package:ajent/app/modules/my_course_detail/widgets/course_status_badge.dart';
import 'package:ajent/app/modules/my_course_detail/widgets/fixed_time_card.dart';
import 'package:ajent/app/modules/my_course_detail/widgets/period_item.dart';
import 'package:ajent/app/modules/my_course_detail/widgets/user_relation_badge.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MyCourseDetailPage extends StatelessWidget {
  contentStyle([Color color = Colors.black]) => GoogleFonts.nunitoSans(
      fontSize: 14, fontWeight: FontWeight.w700, color: color);
  final titleStyle =
      GoogleFonts.nunitoSans(fontSize: 16, fontWeight: FontWeight.bold);
  final Course course = Get.arguments;
  @override
  Widget build(BuildContext context) {
    final MyCourseDetailController controller =
        Get.put(MyCourseDetailController(course));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Course detail'.tr,
          overflow: TextOverflow.fade,
          style: GoogleFonts.nunitoSans(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 1,
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
              onPressed: () {
                controller.showShareBottomSheet(context);
              }),
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
          Obx(
            () => Visibility(
              visible: !controller.isLoading.value,
              child: IconButton(
                  icon: Icon(
                    Icons.info,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    controller.showMoreInfo(context);
                  }),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Hero(
                tag: '${course.id} avatar',
                child: Obx(
                  () => CircleAvatar(
                    child: ClipOval(
                      child: FadeInImage.assetNetwork(
                        fadeInDuration: Duration(milliseconds: 200),
                        fadeOutDuration: Duration(milliseconds: 180),
                        placeholder: 'assets/images/ajent_logo.png',
                        image: course.photoUrl,
                        width: 100,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    radius: 50.0 - controller.scrollOffset.value,
                  ),
                ),
              ),
            ),
            Hero(
              tag: '${course.id} name',
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    course.name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                course.getRelativeAddress(),
                textAlign: TextAlign.center,
                style: GoogleFonts.nunitoSans(fontSize: 14, color: Colors.grey),
              ),
            ),
            Obx(() => AnimatedOpacity(
                duration: Duration(seconds: 1),
                opacity: (controller.isLoading.value) ? 0 : 1,
                child: Column(
                  children: [
                    CourseStatusBadge(
                        status: controller.course.value?.status ??
                            CourseStatus.upcoming),
                    if (controller.userRelation.value !=
                        UserRelation.noRelation)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: UserRelationBadge(
                            relation: controller.userRelation.value),
                      ),
                  ],
                ))),
            CourseOverall(
              course: course,
            ),
            Expanded(
              child: Obx(
                () => (controller.isLoading.value)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Scrollbar(
                        isAlwaysShown: true,
                        child: NotificationListener<ScrollUpdateNotification>(
                          onNotification: (notification) {
                            if (notification.metrics.axisDirection ==
                                    AxisDirection.left ||
                                notification.metrics.axisDirection ==
                                    AxisDirection.right) return false;
                            controller.scrollOffset.value +=
                                notification.scrollDelta / 8;
                            if (controller.scrollOffset.value < 0) {
                              controller.scrollOffset.value = 0;
                              return false;
                            }
                            if (controller.scrollOffset.value > 25) {
                              controller.scrollOffset.value = 25;
                              return false;
                            }
                            return true;
                          },
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 20),
                                Obx(
                                  () => CoursePersonnel(
                                    teacher: controller.teacher,
                                    learners: controller.learners.value,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 10),
                                  child: Text(
                                    'Description'.tr,
                                    style: titleStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25, top: 5, right: 20),
                                  child: InkWell(
                                    onTap: () {
                                      controller.showMore.value =
                                          !controller.showMore.value;
                                    },
                                    child: Obx(
                                      () => Text(
                                        controller.course.value.description
                                                .trim()
                                                .isNotEmpty
                                            ? (controller
                                                .course.value.description)
                                            : "Not available".tr,
                                        style: contentStyle(controller
                                                .course.value.description
                                                .trim()
                                                .isNotEmpty
                                            ? Colors.black
                                            : Colors.grey),
                                        maxLines: (controller.showMore.value)
                                            ? 100
                                            : 5,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 10),
                                  child: Text(
                                    'Address'.tr,
                                    style: titleStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25, top: 5, right: 20),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: Get.width - 90,
                                        child: Text(
                                          controller.course.value.address,
                                          style: contentStyle(controller
                                                  .course.value.address
                                                  .trim()
                                                  .isNotEmpty
                                              ? Colors.black
                                              : Colors.grey),
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (course.address.isNotEmpty)
                                        ClipOval(
                                          child: InkWell(
                                            onTap: () {
                                              launch(
                                                  'https://www.google.com/maps/search/?api=1&query=${course.address}');
                                            },
                                            child: Tooltip(
                                              preferBelow: false,
                                              message: 'open_in_gg_map'.tr,
                                              child: Material(
                                                  color: Colors.transparent,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 5, 10, 5),
                                                    child: Icon(Icons.place,
                                                        color: Colors.blue),
                                                  )),
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 5),
                                  child: Text(
                                    'Specific time'.tr,
                                    style: titleStyle,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 25, top: 5),
                                  child: Text(
                                    controller.timeOverall,
                                    style: contentStyle(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (course.timeType == TimeType.periodTime)
                                  SizedBox(
                                    height: 80,
                                    child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller
                                          .course.value.periods.length,
                                      itemBuilder: (context, index) {
                                        return PeriodItem(
                                          index: index,
                                          period: controller
                                              .course.value.periods[index],
                                        );
                                      },
                                    ),
                                  )
                                else
                                  SizedBox(
                                    height: 160,
                                    width: double.infinity,
                                    child: FixedTimeCard(
                                      fixedTime:
                                          controller.course.value.fixedTime,
                                    ),
                                  ),
                                if (course.subjects.length > 0)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 10),
                                    child: Text(
                                      'Topics'.tr,
                                      style: titleStyle,
                                    ),
                                  ),
                                if (course.subjects.length > 0)
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(25, 5, 25, 5),
                                    child: SizedBox(
                                      height: 24,
                                      child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: course.subjects.length,
                                        itemBuilder: (context, index) {
                                          if (course.subjects[index].isEmpty)
                                            return SizedBox();
                                          return SubjectBadge(
                                              content: course.subjects[index]);
                                        },
                                      ),
                                    ),
                                  ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 10),
                                  child: Text(
                                    'Requirement'.tr,
                                    style: titleStyle,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 25, top: 5),
                                  child: Text(
                                    controller.course.value.requirements
                                            .trim()
                                            .isNotEmpty
                                        ? controller.course.value.requirements
                                        : "Not available".tr,
                                    style: contentStyle(controller
                                            .course.value.requirements
                                            .trim()
                                            .isNotEmpty
                                        ? Colors.black
                                        : Colors.grey),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            Obx(
              () => (controller.requestable.value ||
                      controller.joinable.value ||
                      controller.evaluable.value ||
                      controller.unEnrollable.value)
                  ? Visibility(
                      visible: (MediaQuery.of(context).viewInsets.bottom == 0),
                      child: Container(
                        height: kBottomNavigationBarHeight + 15,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (controller.requestable.value)
                                  ElevatedButton(
                                    onPressed: () {
                                      controller.sendRequest();
                                    },
                                    style: orangeButtonStyle,
                                    child: (controller.isRequesting.value)
                                        ? SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.white),
                                            ),
                                          )
                                        : Text("Request to teach".tr,
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700)),
                                  ),
                                if (controller.joinable.value)
                                  ElevatedButton(
                                    onPressed: () {
                                      controller.joinCourse();
                                    },
                                    style: (controller.requestable.value)
                                        ? whiteButtonStyle
                                        : orangeButtonStyle,
                                    child: (controller.isJoining.value)
                                        ? SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      (controller.requestable
                                                              .value)
                                                          ? Colors.black
                                                          : Colors.white),
                                            ),
                                          )
                                        : Text("Join".tr,
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700)),
                                  ),
                                if (controller.unEnrollable.value)
                                  ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text('confirm'.tr),
                                                content: Text(
                                                    'confirm_leave_course'.tr),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: Text('no'.tr),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      controller.leaveCourse();
                                                      Get.back();
                                                    },
                                                    child: Text('yes'.tr),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: primaryColor,
                                                    ),
                                                  ),
                                                ],
                                              ));
                                    },
                                    style: orangeButtonStyle,
                                    child: (controller.isLeaving.value)
                                        ? SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.white),
                                            ),
                                          )
                                        : Text("Leave course".tr,
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700)),
                                  ),
                                if (controller.evaluable.value)
                                  ElevatedButton(
                                    onPressed: controller.evaluateCourse,
                                    style: orangeButtonStyle,
                                    child: (controller.isRequesting.value)
                                        ? SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.white),
                                            ),
                                          )
                                        : Text(
                                            (controller.course.value.evaluations
                                                    .containsKey(
                                                        controller.user.uid))
                                                ? "See your ratings".tr
                                                : "Rate".tr,
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
      ),
    );
  }
}

class SubjectBadge extends StatelessWidget {
  final String content;
  const SubjectBadge({Key key, @required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.20),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
              child: Center(
                child: Text(content,
                    maxLines: 1,
                    style: GoogleFonts.nunitoSans(
                        color: Colors.black.withOpacity(0.9),
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
