import 'package:ajent/app/modules/my_profile/my_profile_controller.dart';
import 'package:ajent/app/modules/my_profile/widgets/my_button.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class StudentDetail extends StatelessWidget {
  final MyProfileController controller;

  List<DropdownMenuItem<String>> dropDownMenuItems = <String>[
    'drop_down_item1',
    'drop_down_item2',
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();

  StudentDetail({Key key, @required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime _dateTime;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('student_name_label'),
          centerTitle: true,
          backgroundColor: primaryColor,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text("student_name_label",
                    style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: TextField(
                    decoration: primaryTextFieldDecoration,
                    cursorColor: primaryColor,
                    onChanged: (value) {
                      controller.studentName.value = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("student_gender_label",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.bold)),
                    DropdownButton<String>(
                      value: dropDownMenuItems[0].value,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (newValue) {
                        controller.studentGender.value = newValue;
                      },
                      items: dropDownMenuItems,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("student_birthDay_label",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.bold)),
                    TextButton.icon(
                      label: Text('Pick a date'),
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: _dateTime == null
                                    ? DateTime.now()
                                    : _dateTime,
                                firstDate: DateTime(1999),
                                lastDate: DateTime(2022))
                            .then((date) {
                          if (date != null) {
                            controller.studentBirthDay.value = date;
                          }
                        });
                      },
                    ),
                    Text('${DateFormat('dd-MM-yyyy').format(DateTime.now())}'),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("student_address_label",
                    style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: TextField(
                    decoration: primaryTextFieldDecoration,
                    cursorColor: primaryColor,
                    onChanged: (value) {
                      controller.studentAddress.value = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("student_phone_label",
                    style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: TextField(
                    decoration: primaryTextFieldDecoration,
                    cursorColor: primaryColor,
                    onChanged: (value) {
                      controller.studentPhone.value = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("student_email_label",
                    style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: TextField(
                    decoration: primaryTextFieldDecoration,
                    cursorColor: primaryColor,
                    onChanged: (value) {
                      controller.studentMail.value = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MyButton(
                      onPressed: () async {
                        await controller.onPressedStudentConfirm(context);
                        controller.students.value = await controller.userService
                            .getStudents(controller.ajentUser.value.uid);
                      },
                      icon: Icon(Icons.check),
                      label: Text('Confirm'),
                    ),
                    MyButton(
                      onPressed: () {
                        controller.onPressedStudentCancel(context);
                      },
                      icon: Icon(Icons.cancel),
                      label: Text('Cancel'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
