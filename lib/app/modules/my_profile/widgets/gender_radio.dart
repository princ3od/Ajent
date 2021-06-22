import 'package:ajent/app/data/models/Person.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenderRadio extends StatefulWidget {
  final ValueChanged<Gender> onChanged;
  final Gender initGender;

  const GenderRadio({Key key, this.onChanged, this.initGender})
      : super(key: key);

  @override
  State<GenderRadio> createState() => _GenderRadioState();
}

class _GenderRadioState extends State<GenderRadio> {
  Gender _gender;
  @override
  void initState() {
    super.initState();
    _gender = widget.initGender;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[400])),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: ListTile(
              title: Row(
                children: [
                  SizedBox(
                    child: Image.asset('assets/images/default_avatar_male.png'),
                    height: 35,
                  ),
                ],
              ),
              leading: Radio<Gender>(
                value: Gender.male,
                groupValue: _gender,
                onChanged: (Gender value) {
                  setState(() {
                    _gender = value;
                    widget.onChanged(value);
                  });
                },
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: ListTile(
              title: Row(
                children: [
                  SizedBox(
                    child:
                        Image.asset('assets/images/default_avatar_female.png'),
                    height: 35,
                  ),
                ],
              ),
              leading: Radio<Gender>(
                value: Gender.female,
                groupValue: _gender,
                onChanged: (Gender value) {
                  setState(() {
                    _gender = value;
                    widget.onChanged(value);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
