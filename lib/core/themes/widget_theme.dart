import 'package:ajent/core/values/colors.dart';
import 'package:flutter/material.dart';

final ButtonStyle primaryButtonSytle = ElevatedButton.styleFrom(
  primary: primaryColor,
  padding: EdgeInsets.fromLTRB(5, 12, 5, 12),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
  textStyle: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  ),
);

final ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
  primary: Colors.black87,
  onSurface: primaryColor,
  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
  side: BorderSide(color: Colors.black),
);

final ButtonStyle whiteButtonStyle = ElevatedButton.styleFrom(
  primary: Colors.white,
  onPrimary: Colors.black,
  padding: EdgeInsets.fromLTRB(30, 12, 30, 12),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
  textStyle: TextStyle(
    fontSize: 14,
  ),
);

final ButtonStyle orangeButtonStyle = ElevatedButton.styleFrom(
  primary: primaryColor,
  padding: EdgeInsets.fromLTRB(30, 12, 30, 12),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
  textStyle: TextStyle(
    fontSize: 14,
  ),
);

final InputDecoration searchTextfieldDecoration = InputDecoration(
  hintText: "Search for Courses",
  contentPadding: EdgeInsets.fromLTRB(5, 2, 10, 2),
  fillColor: Colors.grey.shade200,
  filled: true,
  isDense: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(20.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(20.0),
  ),
  prefixIcon: Icon(
    Icons.search,
    color: Colors.grey,
    size: 20,
  ),
);

final InputDecoration primaryTextFieldDecoration = InputDecoration(
  focusedBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
);
