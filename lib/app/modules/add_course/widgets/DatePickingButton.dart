import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DatePickingButton extends StatefulWidget {
  DatePickingButton({Key key, DateTime date, void Function() onPressed})
      : super(key: key) {
    if (date == null)
      this.date = DateTime.now();
    else
      this.date = date;
    this.onPressed = onPressed;
  }

  DateTime date;
  void Function() onPressed;

  @override
  _DatePickingButtonState createState() => _DatePickingButtonState();
}

class _DatePickingButtonState extends State<DatePickingButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.grey[400])),
        child: TextButton(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  DateFormat('MMM, dd yyyy').format(widget.date),
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
          onPressed: widget.onPressed,
        ));
  }
}
