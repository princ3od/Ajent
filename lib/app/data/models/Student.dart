import 'package:ajent/core/utils/enum_converter.dart';

import 'Person.dart';

class Student extends Person {
  String id;
  Student(this.id, String name, DateTime birthDay, Gender gender,
      String address, String phone, String mail)
      : super(name, birthDay, gender, address, phone, mail);
  Student.fromJson({this.id, Map<String, dynamic> data})
      : super(
            data['name'],
            DateTime.parse(data['birthDay'].toDate().toString()),
            EnumConverter.stringToGender(data['gender']),
            data['address'],
            data['phone'],
            data['mail']);
}
