import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TimePickingButton extends StatelessWidget {
  TimePickingButton({@required this.time, @required this.onPressed});

  TimeOfDay time;
  void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.grey[400])),
        child: TextButton(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  time?.format(context) ?? "--:--",
                  style:
                      GoogleFonts.nunitoSans(fontSize: 13, color: Colors.black),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.black,
              )
            ],
          ),
          onPressed: onPressed,
        ));
  }
}
