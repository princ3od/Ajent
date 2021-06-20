import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TimePickingButton extends StatefulWidget {
  TimePickingButton({Key key, TimeOfDay time, void Function() onPressed}) : super(key: key)
  {
    if (time == null)
      this.time = TimeOfDay.now();
    else this.time = time;
    this.onPressed = onPressed;
  }

  TimeOfDay time;
  void Function() onPressed;
  @override
  _TimePickingButtonState createState() => _TimePickingButtonState();
}

class _TimePickingButtonState extends State<TimePickingButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.grey[400])
        ),
        child: TextButton(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.time.format(context),
                  style: GoogleFonts.nunitoSans(fontSize: 13, color: Colors.black),
                ),
              ),
              Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black,)
            ],
          ),
          onPressed: widget.onPressed,
        )
    );
  }
}
