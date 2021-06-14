import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function onPressed;
  final Icon icon;
  final Widget label;

  const MyButton(
      {Key key,
      @required this.onPressed,
      @required this.icon,
      @required this.label})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(90),
        ),
        onPrimary: Colors.black,
        primary: Colors.deepOrange,
      ),
      onPressed: onPressed,
      icon: icon,
      label: label,
    );
  }
}
