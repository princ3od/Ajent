import 'dart:io';
import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/models/lesson_time.dart';
import 'package:ajent/routes/pages.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'edit_course_controller.dart';
import 'package:ajent/app/data/models/Period.dart';
import 'package:ajent/app/modules/add_course/widgets/DatePickingButton.dart';
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

class EditCoursePage extends StatelessWidget {
  final Course course = Get.arguments;
  final EditCourseController controller =
      Get.put(EditCourseController(Get.arguments));
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
          onPressed: () =>
              Get.offAndToNamed(Routes.MYCOURSEDETAIL, arguments: course),
        ),
        title: Text(
          'Update course info'.tr,
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
                    Text(
                      "course's_name_label".tr,
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
                      "description_label".tr,
                      style: GoogleFonts.nunitoSans(),
                    ),
                    TextField(
                      cursorColor: primaryColor,
                      decoration: primaryTextFieldDecoration,
                      controller: controller.txtCourseDescription,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "subject_field_label".tr,
                      style: GoogleFonts.nunitoSans(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldTags(
                      initialTags: controller.subjects,
                      tagsStyler: TagsStyler(
                        showHashtag: true,
                        tagMargin: const EdgeInsets.only(right: 4.0),
                        tagCancelIcon:
                            Icon(Icons.cancel, size: 15.0, color: Colors.white),
                        tagCancelIconPadding:
                            EdgeInsets.only(left: 4.0, top: 2.0),
                        tagPadding: EdgeInsets.only(
                            top: 2.0, bottom: 4.0, left: 8.0, right: 4.0),
                        tagDecoration: BoxDecoration(
                          color: primaryColor,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        tagTextStyle: TextStyle(
                            fontWeight: FontWeight.normal, color: Colors.white),
                      ),
                      textFieldStyler: TextFieldStyler(
                        helperText: null,
                        hintText: "Tags",
                        textStyle: GoogleFonts.nunitoSans(),
                        isDense: false,
                        textFieldBorder: null,
                        textFieldFocusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: primaryColor, width: 1.0),
                        ),
                      ),
                      onDelete: (tag) {
                        controller.subjects.remove(tag);
                        print(controller.subjects);
                      },
                      onTag: (tag) {
                        controller.subjects.add(tag);
                      },
                      validator: (String tag) {
                        if (tag.length > 10) {
                          return "too_long_tag_warning".tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "number_of_student_label".tr,
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
                      "tuition_label".tr,
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
                      "location_label".tr,
                      style: GoogleFonts.nunitoSans(),
                    ),
                    TextField(
                      cursorColor: primaryColor,
                      decoration: primaryTextFieldDecoration,
                      controller: controller.txtCourseAddress,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "time_label_on_add".tr,
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
                    Obx(() => Visibility(
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
                                  content: 'day_2'.tr,
                                  onPressed: (val) {
                                    controller.days[0] = val;
                                  },
                                  value: controller.days[0],
                                )),
                                Expanded(
                                    child: TextCheckBox(
                                        content: 'day_3'.tr,
                                        onPressed: (val) {
                                          controller.days[1] = val;
                                        },
                                        value: controller.days[1])),
                                Expanded(
                                    child: TextCheckBox(
                                        content: 'day_4'.tr,
                                        onPressed: (val) {
                                          controller.days[2] = val;
                                        },
                                        value: controller.days[2])),
                                Expanded(
                                    child: TextCheckBox(
                                        content: 'day_5'.tr,
                                        onPressed: (val) {
                                          controller.days[3] = val;
                                        },
                                        value: controller.days[3])),
                                Expanded(
                                    child: TextCheckBox(
                                        content: 'day_6'.tr,
                                        onPressed: (val) {
                                          controller.days[4] = val;
                                        },
                                        value: controller.days[4])),
                                Expanded(
                                    child: TextCheckBox(
                                        content: 'day_7'.tr,
                                        onPressed: (val) {
                                          controller.days[5] = val;
                                        },
                                        value: controller.days[5])),
                                Expanded(
                                    child: TextCheckBox(
                                        content: 'day_1'.tr,
                                        onPressed: (val) {
                                          controller.days[6] = val;
                                        },
                                        value: controller.days[6])),
                              ],
                            ),
                            SizedBox(
                              height: 10,
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
                                          hour:
                                              controller.startTime.value.hour +
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
                                    'to'.tr,
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
                        ))),
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
                              "begin_date_end_date_label".tr,
                              style: GoogleFonts.nunitoSans(),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'to'.tr,
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
                    Text(
                      "special_requirement_label".tr,
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
                      controller.onEditCourse();
                    },
                    style: orangeButtonStyle,
                    child: Obx(
                      () => (controller.isUpdating.value)
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text('Update'.tr,
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
