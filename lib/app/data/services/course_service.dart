import 'package:ajent/app/data/models/Course.dart';
import 'package:ajent/app/data/services/collection_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    await database
        .collection(collectionName)
        .doc(id)
        .get()
        .then((value) => course = Course.fromJson(id, value.data()));
    return course;
  }

  Future<List<Course>> getUserLearningCourse(String userUid) async {
    List<Course> courses = [];
    await database
        .collection(collectionName)
        .where('owner', isEqualTo: userUid)
        .get()
        .then((value) => value.docs.forEach((element) {
              courses.add(Course.fromJson(element.id, element.data()));
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
