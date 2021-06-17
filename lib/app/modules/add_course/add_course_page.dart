import 'package:ajent/app/data/models/Course.dart';
import 'package:ajent/app/data/models/LessonTime.dart';
import 'package:ajent/app/data/models/Period.dart';
import 'package:ajent/app/modules/add_course/add_course_controller.dart';
import 'package:ajent/app/modules/add_course/widgets/DatePickingButton.dart';
import 'package:ajent/app/modules/add_course/widgets/PeriodDayPicker.dart';
import 'package:ajent/app/modules/add_course/widgets/RoundDropdownButton.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/utils/enum_converter.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:ajent/core/values/lang/en_us.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddCoursePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AddCourseController controller = Get.find<AddCourseController>();
    final int pageIndex = ModalRoute.of(context).settings.arguments as int;

    return Scaffold(
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
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
                          child: Image(
                            image: AssetImage('assets/images/no_img.png'),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
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
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Mã khóa",
                            style: GoogleFonts.nunitoSans(),
                          ),
                          TextField(
                            cursorColor: primaryColor,
                            decoration: primaryTextFieldDecoration,
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
                    items: controller.topics.map((item) => DropdownMenuItem(
                      child: Text(item, style: GoogleFonts.nunitoSans(fontSize: 13)),
                      value: item,
                    )).toList(),
                    onChanged: (selectedItem) {
                      controller.selectedTopic.value = selectedItem;
                    },
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                "Hình thức khóa học",
                style: GoogleFonts.nunitoSans(),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() => RoundedDropdownButton(
                    value: controller.selectedType.value,
                    items: controller.courseTypes.map((item) => DropdownMenuItem(
                      child: Text(item, style: GoogleFonts.nunitoSans(fontSize: 13)),
                      value: item,
                    )).toList(),
                    onChanged: (selectedItem) {
                      controller.selectedType.value = selectedItem;
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
                            items: controller.timeTypes.map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(EnumConverter.timeTypeToString(item).tr, style: GoogleFonts.nunitoSans(fontSize: 13),),
                            )).toList(),
                            onChanged: (selectedItem) {
                              controller.selectedTimeType.value = selectedItem;
                            },
                          )),
                    ),
                  ),
                  Obx(() => Visibility(
                    visible: (controller.selectedTimeType.value == TimeType.fixedTime) ? true : false,
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

                        start = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(hour: 12, minute: 0));

                        end = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(hour: 12, minute: 0));
                        var x = Period(date, LessonTime(start, end));
                        controller.periods.add(x);
                      },
                    ),
                  ))
                ],
              ),
              Obx(() => Wrap(
                    children: controller.periods.map((element) {
                      String date = DateFormat("dd/MM/yy").format(element.date);
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
                  )),
              Obx(() => Visibility(
                visible: (controller.selectedTimeType.value == TimeType.periodTime) ? true : false,
                child: PeriodDayPicker(
                  onAddButtonPress: (index) {
                    //Add day & time here
                    //index = [0, 1, 2, 3,..,6] ~ [t2, T3, T4, T5,...,T6]
                    print(index);
                  },
                ),
              ),),
              SizedBox(
                height: 10,
              ),
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
                    child: Obx(() => DatePickingButton(
                          date: controller.startDate.value,
                          onPressed: () async {
                            controller.startDate.value = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(DateTime.now().year + 10));
                          },
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('đến', style: GoogleFonts.nunitoSans(),),
                  ),
                  Expanded(
                    child: Obx(() => DatePickingButton(
                          date: controller.endDate.value,
                          onPressed: () async {
                            controller.endDate.value = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(DateTime.now().year + 10));
                          },
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: (pageIndex == 1) ? true : false,
                child: Row(
                  children: [
                    Text(
                      "Thông tin học sinh",
                      style: GoogleFonts.nunitoSans(),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () async {
                        controller.learners.add('Hoc sinh');
                      },
                    )
                  ],
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
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: orangeButtonStyle,
                  child: Text(
                    'Mở lớp',
                    style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
