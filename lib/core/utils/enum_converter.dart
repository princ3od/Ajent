import 'package:ajent/app/data/models/Person.dart';

class EnumConverter {
  static String genderToString(Gender gender) {
    switch (gender) {
      case Gender.male:
        return "male";
      case Gender.female:
        return "female";
      default:
        return "";
    }
  }

  static Gender stringToGender(String data) {
    switch (data) {
      case "male":
        return Gender.male;
      case "female":
        return Gender.female;
      default:
        return Gender.male;
    }
  }
}
