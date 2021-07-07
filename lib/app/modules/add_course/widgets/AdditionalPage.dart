import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/models/lesson_time.dart';
import 'package:ajent/app/data/models/Period.dart';
import 'package:ajent/app/modules/add_course/add_course_controller.dart';
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

class AdditionalPage extends StatelessWidget {
  AdditionalPage({Key key}) : super(key: key);

  final int pageIndex = Get.arguments;
  final AddCourseController controller =
      Get.put(AddCourseController(Get.arguments));
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                                        EnumConverter.timeTypeToString(item).tr,
                                        style: GoogleFonts.nunitoSans(
                                            fontSize: 13),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (selectedItem) {
                              controller.selectedTimeType.value = selectedItem;
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
                              lastDate: DateTime(DateTime.now().year + 10),
                            );
                            if (date == null) {
                              return;
                            }
                            start = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(hour: 12, minute: 0));
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
                            labelStyle:
                                TextStyle(fontSize: 13, color: Colors.white),
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
                  visible:
                      (controller.selectedTimeType.value == TimeType.fixedTime)
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
                                if (controller.startTime.value?.hour == null ??
                                    false ||
                                        controller.startTime.value?.minute ==
                                            null ??
                                    false) {
                                  return;
                                }
                                controller.endTime.value = TimeOfDay(
                                    hour: controller.startTime.value.hour + 1,
                                    minute:
                                        controller.startTime.value.minute + 30);
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
                                controller.endTime.value = await showTimePicker(
                                    context: context,
                                    initialTime: controller.endTime.value);
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
                  visible:
                      (controller.selectedTimeType.value == TimeType.fixedTime)
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
                                                DateTime.now().year + 10));
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
                                                DateTime.now().year + 10));
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
                            labelStyle:
                                TextStyle(fontSize: 13, color: Colors.white),
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
    );
  }
}
