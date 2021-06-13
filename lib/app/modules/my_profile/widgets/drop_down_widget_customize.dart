import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDropDownWidget extends StatelessWidget {
  final Function onChanged;
  final dynamic value;
  final List<DropdownMenuItem<dynamic>> items;

  MyDropDownWidget(
      {Key key,
      @required this.onChanged,
      @required this.items,
      @required this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.grey[400])),
        child: DropdownButton(
          icon: Icon(Icons.keyboard_arrow_down_rounded),
          isExpanded: true,
          underline: SizedBox(),
          onChanged: onChanged,
          value: value,
          items: items,
        ));
  }
}
