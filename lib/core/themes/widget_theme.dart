import 'package:ajent/core/values/colors.dart';
import 'package:flutter/material.dart';

final ButtonStyle primaryButtonSytle = ElevatedButton.styleFrom(
  primary: primaryColor,
  padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
  textStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
);

final ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
  primary: Colors.black87,
  onSurface: primaryColor,
  padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
  side: BorderSide(color: Colors.black),
);
