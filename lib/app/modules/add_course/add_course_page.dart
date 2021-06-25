import 'dart:io';

import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/models/LessonTime.dart';
import 'package:ajent/app/data/models/Period.dart';
import 'package:ajent/app/modules/add_course/add_course_controller.dart';
import 'package:ajent/app/modules/add_course/widgets/DatePickingButton.dart';
import 'package:ajent/app/modules/add_course/widgets/PeriodDayPicker.dart';
import 'package:ajent/app/modules/add_course/widgets/RoundDropdownButton.dart';
import 'package:ajent/app/modules/add_course/widgets/TextCheckBox.dart';
import 'package:ajent/app/modules/add_course/widgets/TimePickingButton.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/utils/enum_converter.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddCoursePage extends StatelessWidget {
  final int pageIndex = Get.arguments;
  final AddCourseController controller =
      Get.put(AddCourseController(Get.arguments));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.grey[100],
        toolbarHeight: 70.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Mở lớp',
          style: GoogleFonts.nunitoSans(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 110,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Obx(
                                  () => (controller.imagePath.isEmpty)
                                      ? Image(
                                          image: AssetImage(
                                              'assets/images/no_img.png'),
                                        )
                                      : Image.file(
                                          File(controller.imagePath.value),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                controller.onChangeCouseImage();
                              },
                              child: Text("Đổi ảnh"),
                              style: whiteButtonStyle,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tên khóa học",
                                  style: GoogleFonts.nunitoSans(),
                                ),
                                TextField(
                                  cursorColor: primaryColor,
                                  decoration: primaryTextFieldDecoration,
                                  controller: controller.txtCourseName,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Mô tả",
                                  style: GoogleFonts.nunitoSans(),
                                ),
                                TextField(
                                  cursorColor: primaryColor,
                                  decoration: primaryTextFieldDecoration,
                                  controller: controller.txtCourseDescription,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Đề tài khóa học",
                      style: GoogleFonts.nunitoSans(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(() => RoundedDropdownButton(
                          value: controller.selectedTopic.value,
                          items: controller.topics
                              .map((item) => DropdownMenuItem(
                                    child: Text(item,
                                        style: GoogleFonts.nunitoSans(
                                            fontSize: 13)),
                                    value: item,
                                  ))
                              .toList(),
                          onChanged: (selectedItem) {
                            controller.selectedTopic.value = selectedItem;
                          },
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Số lượng học viên",
                      style: GoogleFonts.nunitoSans(),
                    ),
                    TextField(
                      cursorColor: primaryColor,
                      decoration: primaryTextFieldDecoration,
                      controller: controller.txtStudentNum,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Giá tiền đề nghị (vnd)",
                      style: GoogleFonts.nunitoSans(),
                    ),
                    TextField(
                      cursorColor: primaryColor,
                      decoration: primaryTextFieldDecoration,
                      controller: controller.txtCoursePrice,
                      onChanged: controller.formatCurrencyText,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Địa điểm học",
                      style: GoogleFonts.nunitoSans(),
                    ),
                    TextField(
                      cursorColor: primaryColor,
                      decoration: primaryTextFieldDecoration,
                      controller: controller.txtCourseAddress,
                      autofocus: false,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Thời gian",
                          style: GoogleFonts.nunitoSans(),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Obx(() => RoundedDropdownButton(
                                  value: controller.selectedTimeType.value,
                                  items: controller.timeTypes
                                      .map((item) => DropdownMenuItem(
                                            value: item,
                                            child: Text(
                                              EnumConverter.timeTypeToString(
                                                      item)
                                                  .tr,
                                              style: GoogleFonts.nunitoSans(
                                                  fontSize: 13),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (selectedItem) {
                                    controller.selectedTimeType.value =
                                        selectedItem;
                                  },
                                )),
                          ),
                        ),
                        Obx(() => Visibility(
                              visible: (controller.selectedTimeType.value ==
                                      TimeType.periodTime)
                                  ? true
                                  : false,
                              child: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () async {
                                  //It's just design code, its jobs is add a new periods
                                  TimeOfDay start, end;
                                  DateTime date;
                                  date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate:
                                        DateTime(DateTime.now().year + 10),
                                  );
                                  if (date == null) {
                                    return;
                                  }
                                  start = await showTimePicker(
                                      context: context,
                                      initialTime:
                                          TimeOfDay(hour: 12, minute: 0));
                                  if (start == null) {
                                    return;
                                  }
                                  end = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay(
                                          hour: start.hour + 2,
                                          minute: start.minute));
                                  if (end == null) {
                                    return;
                                  }
                                  LessonTime lessonTime = LessonTime()
                                    ..startTime = start
                                    ..endTime = end;
                                  var x = Period(date, lessonTime);
                                  controller.periods.add(x);
                                },
                              ),
                            ))
                      ],
                    ),
                    Obx(() => Visibility(
                          visible: (controller.selectedTimeType.value ==
                              TimeType.periodTime),
                          child: Wrap(
                            children: controller.periods.map((element) {
                              String date =
                                  DateFormat("dd/MM/yy").format(element.date);
                              String startTime =
                                  element.lessonTime.startTime.format(context);
                              String endTime =
                                  element.lessonTime.endTime.format(context);
                              return Padding(
                                padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                child: InputChip(
                                  label: Column(
                                    children: [
                                      Text(date),
                                      Text('$startTime - $endTime'),
                                    ],
                                  ),
                                  labelStyle: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                  backgroundColor: primaryColor,
                                  onDeleted: () {
                                    controller.periods.remove(element);
                                  },
                                  deleteIconColor: Colors.white,
                                ),
                              );
                            }).toList(),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => Visibility(
                          visible: (controller.selectedTimeType.value ==
                                  TimeType.fixedTime)
                              ? true
                              : false,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: TextCheckBox(
                                    content: 'T2',
                                    onPressed: (val) =>
                                        controller.days[0] = val,
                                  )),
                                  Expanded(
                                      child: TextCheckBox(
                                    content: 'T3',
                                    onPressed: (val) =>
                                        controller.days[1] = val,
                                  )),
                                  Expanded(
                                      child: TextCheckBox(
                                    content: 'T4',
                                    onPressed: (val) =>
                                        controller.days[2] = val,
                                  )),
                                  Expanded(
                                      child: TextCheckBox(
                                    content: 'T5',
                                    onPressed: (val) =>
                                        controller.days[3] = val,
                                  )),
                                  Expanded(
                                      child: TextCheckBox(
                                    content: 'T6',
                                    onPressed: (val) =>
                                        controller.days[4] = val,
                                  )),
                                  Expanded(
                                      child: TextCheckBox(
                                    content: 'T7',
                                    onPressed: (val) =>
                                        controller.days[5] = val,
                                  )),
                                  Expanded(
                                      child: TextCheckBox(
                                    content: 'CN',
                                    onPressed: (val) =>
                                        controller.days[6] = val,
                                  )),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Obx(
                                    () => TimePickingButton(
                                      time: controller.startTime.value,
                                      onPressed: () async {
                                        controller.startTime.value =
                                            await showTimePicker(
                                                context: context,
                                                initialTime:
                                                    controller.startTime.value);
                                        if (controller.startTime.value?.hour ==
                                                null ??
                                            false ||
                                                controller.startTime.value
                                                        ?.minute ==
                                                    null ??
                                            false) {
                                          return;
                                        }
                                        controller.endTime.value = TimeOfDay(
                                            hour: controller
                                                    .startTime.value.hour +
                                                1,
                                            minute: controller
                                                    .startTime.value.minute +
                                                30);
                                      },
                                    ),
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'đến',
                                      style: GoogleFonts.nunitoSans(),
                                    ),
                                  ),
                                  Expanded(
                                      child: Obx(
                                    () => TimePickingButton(
                                      time: controller.endTime.value,
                                      onPressed: () async {
                                        controller.endTime.value =
                                            await showTimePicker(
                                                context: context,
                                                initialTime:
                                                    controller.endTime.value);
                                      },
                                    ),
                                  ))
                                ],
                              )
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => Visibility(
                        visible: (controller.selectedTimeType.value ==
                                TimeType.fixedTime)
                            ? true
                            : false,
                        child: Column(
                          children: [
                            Text(
                              "Ngày bắt đầu - kết thúc dự kiến",
                              style: GoogleFonts.nunitoSans(),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
<<<<<<< HEAD
                                  child: Obx(() => DatePickingButton(
                                        date: controller.startDate.value,
                                        onPressed: () async {
                                          controller.startDate.value =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(
                                                      DateTime.now().year +
                                                          10));
                                          controller.endDate.value = controller
                                              .startDate.value
                                              .add(Duration(days: 7));
                                        },
                                      )),
                                ),
=======
                                    child: TextCheckBox(content: 'T2', onPressed: (val) { controller.days[0] = val;}, value: controller.days[0],)
                                ),
                                Expanded(
                                    child: TextCheckBox(content: 'T3', onPressed: (val) { controller.days[1] = val;}, value: controller.days[1])
                                ),
                                Expanded(
                                    child: TextCheckBox(content: 'T4', onPressed: (val) { controller.days[2] = val;}, value: controller.days[2])
                                ),
                                Expanded(
                                    child: TextCheckBox(content: 'T5', onPressed: (val) { controller.days[3] = val;}, value: controller.days[3])
                                ),
                                Expanded(
                                    child: TextCheckBox(content: 'T6', onPressed: (val) { controller.days[4] = val;}, value: controller.days[4])
                                ),
                                Expanded(
                                    child: TextCheckBox(content: 'T7', onPressed: (val) { controller.days[5] = val;}, value: controller.days[5])
                                ),
                                Expanded(
                                    child: TextCheckBox(content: 'CN', onPressed: (val) { controller.days[6] = val;}, value: controller.days[6])
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: TimePickingButton(
                                  time: controller.startTime.value,
                                  onPressed: () async {
                                    controller.startTime.value = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay(hour: 0, minute: 0)
                                    );
                                  },
                                )),
>>>>>>> 323d652 (Fix TextCheckBox)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'đến',
                                    style: GoogleFonts.nunitoSans(),
                                  ),
                                ),
                                Expanded(
                                  child: Obx(() => DatePickingButton(
                                        date: controller.endDate.value,
                                        onPressed: () async {
                                          controller.endDate.value =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(
                                                      DateTime.now().year +
                                                          10));
                                        },
                                      )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Visibility(
                            //   visible: (pageIndex == 1) ? true : false,
                            //   child: Row(
                            //     children: [
                            //       Text(
                            //         "Thông tin học sinh",
                            //         style: GoogleFonts.nunitoSans(),
                            //       ),
                            //       IconButton(
                            //         icon: Icon(Icons.add),
                            //         onPressed: () async {
                            //           controller.learners.add('Hoc sinh');
                            //         },
                            //       )
                            //     ],
                            //   ),
                            // ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: (pageIndex == 1) ? true : false,
                      child: Obx(() => Wrap(
                            children: controller.learners.map((element) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                child: InputChip(
                                  label: Text(element),
                                  labelStyle: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                  backgroundColor: primaryColor,
                                  onDeleted: () {
                                    controller.learners.remove(element);
                                  },
                                  deleteIconColor: Colors.white,
                                ),
                              );
                            }).toList(),
                          )),
                    ),
                    Text(
                      "Yêu cầu đặc biệt",
                      style: GoogleFonts.nunitoSans(),
                    ),
                    TextField(
                      cursorColor: primaryColor,
                      decoration: primaryTextFieldDecoration,
                      controller: controller.txtCourseRequirements,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: MediaQuery.of(context).viewInsets.bottom == 0,
            child: Container(
              height: kBottomNavigationBarHeight + 15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Divider(),
                  ElevatedButton(
                    onPressed: () {
                      controller.onAddCourse();
                    },
                    style: orangeButtonStyle,
                    child: Obx(
                      () => (controller.isAddingCourse.value)
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text("Mở lớp",
                              style: GoogleFonts.nunitoSans(
                                  fontSize: 14, fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
