import 'package:ajent/core/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextCheckBox extends StatefulWidget {
  TextCheckBox({Key key, @required String content, bool value = false, void Function(bool) onPressed}) : super(key: key){
    this.content = content;
    this.onPressed = onPressed;
    this._value = value;
  }

  bool _value;
  String content;
  void Function(bool) onPressed;

  @override
  _TextCheckBoxState createState() => _TextCheckBoxState();
}

class _TextCheckBoxState extends State<TextCheckBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget._value = !widget._value;
        });
        if (widget.onPressed != null)
          widget.onPressed(widget._value);
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: widget._value ? primaryColor : Colors.transparent),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text(widget.content, style: GoogleFonts.nunitoSans(color: widget._value ? Colors.white : Colors.black),)),
        ),
      ),
    );
  }
}
