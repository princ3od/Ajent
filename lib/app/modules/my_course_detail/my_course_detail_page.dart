import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:ajent/app/modules/my_course_detail/my_course_detail_controller.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class MyCourseDetailPage extends StatelessWidget {
  final Course course = Get.arguments;
  @override
  Widget build(BuildContext context) {
    final MyCourseDetailController controller =
        Get.put(MyCourseDetailController(course));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Chi tiết khoá học',
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
      body: Column(
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
          if (course.status == CourseStatus.fininished)
            Center(
              child: OutlinedButton(
                style: outlinedButtonStyle,
                onPressed: () {
                  Get.toNamed(Routes.RATING,
                      arguments: controller.course.value);
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Text(
                    "Đánh giá",
                    style: GoogleFonts.nunitoSans(
                        fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                ),
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
                              Text("Mã khóa",
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
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
                              Text("Họ và tên giảng viên",
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                child: TextFormField(
                                  onTap: () {
                                    if (controller.teacher != null)
                                      Get.toNamed(Routes.PROFILEVIEW,
                                          arguments: controller.teacher);
                                  },
                                  initialValue: controller.teacher?.name ??
                                      "Chưa có", //Get a link here to get to teacher profile page
                                  decoration: primaryTextFieldDecoration,
                                  cursorColor: primaryColor,
                                  readOnly: true,
                                  style: GoogleFonts.nunitoSans(
                                      color: (controller.teacher != null)
                                          ? Colors.blue
                                          : Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                ),
                              ),
                              Text("Số điện thoại giảng viên",
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                child: TextFormField(
                                  onTap: () async {
                                    if (controller.teacher != null &&
                                        controller.teacher.phone != null &&
                                        controller.teacher.phone.isNotEmpty) {
                                      await launch(
                                          'tel: ${controller.teacher.phone}');
                                    }
                                  },
                                  initialValue: (controller.teacher == null ||
                                          controller.teacher?.phone == null)
                                      ? "Không có"
                                      : (controller.teacher.phone.isEmpty)
                                          ? "Không có"
                                          : controller.teacher.phone,
                                  decoration: primaryTextFieldDecoration,
                                  cursorColor: primaryColor,
                                  keyboardType: TextInputType.phone,
                                  readOnly: true,
                                  style: GoogleFonts.nunitoSans(
                                      color:
                                          (controller.teacher?.phone != null &&
                                                  controller
                                                      .teacher.phone.isNotEmpty)
                                              ? Colors.blue
                                              : Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                ),
                              ),
                              Text("Địa điểm học",
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
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
                              Text("Thời gian học",
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                child: TextFormField(
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
                              ),
                              Text("Giá tiền",
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                              TextFormField(
                                initialValue: NumberFormat.currency(
                                        locale: "vi_VN", symbol: "VNĐ")
                                    .format(
                                        controller.course?.value?.price ?? 0),
                                decoration: primaryTextFieldDecoration,
                                cursorColor: primaryColor,
                                readOnly: true,
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w600, fontSize: 12),
                              ),
                              Container(
                                height: 50,
                                child: Align(
                                  alignment: FractionalOffset.bottomCenter,
                                  child: Center(
                                      child: Text("© Ajent ",
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w100,
                                              fontSize: 12))),
                                ),
                              ),
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
    );
  }
}
