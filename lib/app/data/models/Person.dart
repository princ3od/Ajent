abstract class Person {
  String name;
  DateTime birthDay;
  Gender gender;
  String address;
  String phone;
  String mail;
  Person(this.name, this.birthDay, this.gender, this.address, this.phone,
      this.mail);
  bool isInfoUpdated() {
    return (name != null &&
        name.isNotEmpty &&
        (phone != null && phone.isNotEmpty));
  }
}

enum Gender {
  male,
  female,
}
