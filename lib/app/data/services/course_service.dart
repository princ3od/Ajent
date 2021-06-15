import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/models/FixedTime.dart';
import 'package:ajent/app/data/models/Period.dart';
import 'package:ajent/app/data/services/collection_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CourseService implements CollectionInterface {
  CourseService._privateConstructor();
  static final CourseService instance = CourseService._privateConstructor();

  final FirebaseFirestore database = FirebaseFirestore.instance;

  @override
  String collectionName = 'courses';

  Future<Course> addCourse(Course course) async {
    await database
        .collection(collectionName)
        .doc(course.id)
        .set(course.toJson(), SetOptions(merge: true));
    return course;
  }

  Future<Course> getCourse(String id) async {
    Course course;
    await database.collection(collectionName).doc(id).get().then((value) async {
      course = Course.fromJson(id, value.data());
      if (course.timeType == TimeType.fixedTime) {
        await value.reference
            .collection('fixedTime')
            .doc('fixedTime')
            .get()
            .then((value) {
          print(value.data());
          course.fixedTime = FixedTime.fromJson(value.data());
        });
      } else {
        await value.reference.collection('periods').get().then((value) {
          for (var element in value.docs) {
            course.periods.add(Period.fromJson(element.data()));
          }
          course.periods.sort((a, b) => a.date.compareTo(b.date));
        });
      }
    });
    return course;
  }

  Future<List<Course>> getUserLearningCourse(String userUid) async {
    List<Course> courses = [];
    await database
        .collection(collectionName)
        .where('owner', isEqualTo: userUid)
        .get()
        .then((value) async {
      for (var element in value.docs) {
        Course course = Course.fromJson(element.id, element.data());
        DateTime now = DateTime.now();
        if (course.timeType == TimeType.fixedTime) {
          String endDate = '01/01/1980', startDate = '01/01/1970';
          await element.reference
              .collection('fixedTime')
              .doc('fixedTime')
              .get()
              .then((value) {
            startDate = value.data()['startDate'];
            endDate = value.data()['endDate'];
          });
          DateTime start = DateFormat("dd/MM/yyyy").parse(startDate);
          DateTime end = DateFormat("dd/MM/yyyy").parse(endDate);
          if (now.isAfter(end)) {
            course.status = CourseStatus.fininished;
          } else if (now.isBefore(start)) {
            course.status = CourseStatus.upcoming;
          } else {
            course.status = CourseStatus.ongoing;
          }
        } else {
          String lastPeriod = element.data()['lastPeriod'];
          DateTime lastDate = DateFormat("dd/MM/yyyy").parse(lastPeriod);
          if (now.isAfter(lastDate)) {
            course.status = CourseStatus.fininished;
          } else if (now.isBefore(lastDate)) {
            course.status = CourseStatus.upcoming;
          } else {
            course.status = CourseStatus.ongoing;
          }
        }
        courses.add(course);
      }
    });
    return courses;
  }

  Future<List<Course>> getUserTeachingCourse(String userUid) async {
    List<Course> courses = [];
    await database
        .collection(collectionName)
        .where('teacher', isEqualTo: userUid)
        .get()
        .then((value) async {
      for (var element in value.docs) {
        courses.add(Course.fromJson(element.id, element.data()));
      }
    });
    return courses;
  }
}
