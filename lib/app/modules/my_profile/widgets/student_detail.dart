import 'dart:convert';

import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
class StudentDetail extends StatelessWidget {

  DateTime _dateTime;
  StudentDetail({Key key}) : super(key: key);
  List<DropdownMenuItem<String>> dropDownMenuItems = <String>[
    'male',
    'female',
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();

  @override
  Widget build(BuildContext context) {
    DateTime _dateTime = DateTime.now();
    return SafeArea(
      child: Scaffold(
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
          title: Text('student_add_label'.tr, style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 18,fontWeight: FontWeight.w700),),
          centerTitle: true,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text("student_name_label".tr,
                      style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                ),
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
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("student_gender_label".tr,
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold)),
                      DropdownButton<String>(
                        value: dropDownMenuItems[0].value,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                            style:  TextStyle(color:primaryColor ),
                        underline: Container(
                          height: 2,
                          color: primaryColor,
                        ),
                        onChanged: (newValue) {},
                        items: dropDownMenuItems,
                      ),
                    ],
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 32, 0, 32),
                      child: Text("student_birthday_label".tr,
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold)),
                    ),
                    TextButton.icon(
                      label: Text( '${DateFormat('dd-MM-yyyy').format(_dateTime)}'),
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: _dateTime == null
                                    ? DateTime.now()
                                    : _dateTime,
                                firstDate: DateTime(1999),
                                lastDate: DateTime(9999))
                            .then((date) {
                              _dateTime = date;
                        });
                      },
                    ),
                    //Text('${DateFormat('dd-MM-yyyy').format(DateTime.now())}'),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text("student_address_label".tr,
                      style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text("student_phone_label".tr,
                      style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text("student_email_label".tr,
                      style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                  child: TextField(
                    decoration: primaryTextFieldDecoration,
                    cursorColor: primaryColor,
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(onPressed: (){},
                    child: Text("add_student_to_account".tr,style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w700),),
                    style: orangeButtonStyle,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }




}
