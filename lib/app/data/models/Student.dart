import 'Person.dart';

class Student extends Person {
  String id;
  Student(this.id, String name, DateTime birthDay, Gender gender,
      String address, String phone, String mail)
      : super(name, birthDay, gender, address, phone, mail);
}
