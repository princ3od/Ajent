import 'package:ajent/app/data/models/Course.dart';
import 'package:ajent/app/data/models/FixedTime.dart';
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
        print('get time');
        await value.reference
            .collection('fixedTime')
            .doc('fixedTime')
            .get()
            .then((value) {
          print(value.data());
          course.fixedTime = FixedTime.fromJson(value.data());
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
        .then((value) => value.docs.forEach((element) async {
              Course course = Course.fromJson(element.id, element.data());
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
                DateTime now = DateTime.now();
                if (now.isAfter(end)) {
                  course.status = CourseStatus.fininished;
                } else if (now.isBefore(start)) {
                  course.status = CourseStatus.upcoming;
                } else {
                  course.status = CourseStatus.ongoing;
                }
              }
              courses.add(course);
            }));
    return courses;
  }

  Future<List<Course>> getUserTeachingCourse(String userUid) async {
    List<Course> courses = [];
    await database
        .collection(collectionName)
        .where('teacher', isEqualTo: userUid)
        .get()
        .then((value) => value.docs.forEach((element) {
              courses.add(Course.fromJson(element.id, element.data()));
            }));
    return courses;
  }
}
