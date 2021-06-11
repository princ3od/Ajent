import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class StudentDetail extends StatelessWidget {
  StudentDetail({Key key}) : super(key: key);
  List<DropdownMenuItem<String>> dropDownMenuItems = <String>[
    'drop_down_item1',
    'drop_down_item2',
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();

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
                    onChanged: (value) {},
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
                      onChanged: (newValue) {},
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
                            .then((date) {});
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
                    onChanged: (value) {},
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
                    onChanged: (value) {},
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
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
