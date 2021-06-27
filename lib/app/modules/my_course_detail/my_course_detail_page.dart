import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/modules/my_course_detail/my_course_detail_controller.dart';
import 'package:ajent/app/modules/my_course_detail/widgets/course_overrall.dart';
import 'package:ajent/app/modules/my_course_detail/widgets/course_personnel.dart';
import 'package:ajent/app/modules/my_course_detail/widgets/course_status_badge.dart';
import 'package:ajent/app/modules/my_course_detail/widgets/fixed_time_card.dart';
import 'package:ajent/app/modules/my_course_detail/widgets/period_item.dart';
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
          'Chi tiết khoá học',
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
                child: SizedBox(
                  child: Text(
                    course.name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                ),
              ),
            ),
            Text(
              course.address,
              textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(fontSize: 14, color: Colors.grey),
            ),
            Obx(() => AnimatedOpacity(
                duration: Duration(seconds: 1),
                opacity: (controller.isLoading.value) ? 0 : 1,
                child: CourseStatusBadge(
                    status: controller.course.value?.status ??
                        CourseStatus.upcoming))),
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
                                    'Mô tả',
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
                                            : "Không có",
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
                                    'Địa chỉ',
                                    style: titleStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Row(
                                    children: [
                                      Text(
                                        controller.course.value.address,
                                        style: contentStyle(controller
                                                .course.value.address
                                                .trim()
                                                .isNotEmpty
                                            ? Colors.black
                                            : Colors.grey),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      if (course.address.isNotEmpty)
                                        ClipOval(
                                          child: InkWell(
                                            onTap: () {
                                              launch(
                                                  'https://www.google.com/maps/search/?api=1&query=${course.address}');
                                            },
                                            child: Material(
                                                color: Colors.transparent,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 5, 10, 5),
                                                  child: Icon(Icons.map,
                                                      color: Colors.blue),
                                                )),
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 5),
                                  child: Text(
                                    'Thời gian cụ thể',
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
                                    height: 75,
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
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 10),
                                  child: Text(
                                    'Yêu cầu',
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
                                        : "Không có",
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
              () => (controller.requestable.value || controller.joinable.value)
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
                                      //create request
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
                                        : Text("Ứng tuyển dạy",
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
                                                      Colors.white),
                                            ),
                                          )
                                        : Text("Tham gia",
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
