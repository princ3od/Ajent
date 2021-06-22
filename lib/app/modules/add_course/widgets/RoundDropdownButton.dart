import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedDropdownButton extends StatefulWidget {
  RoundedDropdownButton(
      {Key key,
      @required dynamic value,
      @required List<DropdownMenuItem<dynamic>> items,
      void Function(dynamic) onChanged})
      : super(key: key) {
    this.value = value;
    this.items = items;
    this.onChanged = onChanged;
  }
  dynamic value;
  List<DropdownMenuItem<dynamic>> items;
  void Function(dynamic) onChanged;

  @override
  _RoundedDropdownButtonState createState() => _RoundedDropdownButtonState();
}

class _RoundedDropdownButtonState extends State<RoundedDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.grey[400])),
        child: Listener(
          onPointerDown: (_) => FocusScope.of(context).unfocus(),
          child: DropdownButton(
            icon: Icon(Icons.keyboard_arrow_down_rounded),
            isExpanded: true,
            underline: SizedBox(),
            onChanged: widget.onChanged,
            value: widget.value,
            items: widget.items,
          ),
        ));
  }
}
