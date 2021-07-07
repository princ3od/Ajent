import 'package:ajent/core/utils/enum_converter.dart';
import 'package:get/get.dart';

import 'Person.dart';
import 'Degree.dart';

class AjentUser extends Person {
  String uid;
  String avatarUrl;
  String schoolName;
  String major;
  String educationLevel = "";
  List<String> subjects = [];
  String bio;
  List<Degree> degrees = [];
  List<String> topics = [];
  AjentUser(
      this.uid,
      String name,
      DateTime birthDay,
      Gender gender,
      String address,
      String phone,
      String mail,
      this.avatarUrl,
      this.schoolName,
      this.major,
      this.educationLevel,
      this.bio,
      [this.subjects,
      this.degrees])
      : super(name, birthDay, gender, address, phone, mail);

  AjentUser.fromJson(this.uid, Map<String, dynamic> data)
      : super(
            data['name'],
            DateTime.parse(data['birthDay'].toDate().toString()),
            EnumConverter.stringToGender(data['gender']),
            data['address'],
            data['phone'],
            data['mail']) {
    avatarUrl = data['avatarUrl'];
    schoolName = data['schoolName'];
    major = data['major'];
    educationLevel = data['educationLevel'];
    bio = data['bio'];
    topics = List.from(data['topics']);
  }
  AjentUser.cloneWith(AjentUser ajentUser)
      : super(
          ajentUser.name,
          ajentUser.birthDay,
          ajentUser.gender,
          ajentUser.address,
          ajentUser.phone,
          ajentUser.mail,
        ) {
    avatarUrl = ajentUser.avatarUrl;
    schoolName = ajentUser.schoolName;
    major = ajentUser.major;
    educationLevel = ajentUser.educationLevel;
    bio = ajentUser.bio;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'birthDay': this.birthDay,
      'gender': EnumConverter.genderToString(this.gender),
      'address': this.address,
      'phone': this.phone,
      'mail': this.mail,
      'avatarUrl': this.avatarUrl,
      'schoolName': this.schoolName,
      'major': this.major,
      'educationLevel': this.educationLevel,
      'bio': this.bio,
      'indexList': getIndexList(),
      'topics': this.topics,
    };
  }

  bool isInfoUpdated() {
    return (name != null &&
        name.isNotEmpty &&
        name != 'default_name'.tr &&
        (phone != null && phone.isNotEmpty) &&
        (mail != null && mail.isNotEmpty) &&
        (bio != null && bio.isNotEmpty) &&
        (educationLevel.isNotEmpty));
  }

  List<String> getIndexList() {
    List<String> result = [];
    List<String> words = name.split(' ').toList();
    for (var word in words) {
      for (var i = 0; i < word.length + 1; i++) {
        result.add(word.substring(0, i).toLowerCase());
      }
    }
    return result;
  }
}
