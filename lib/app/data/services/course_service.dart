import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/models/fixed_time.dart';
import 'package:ajent/app/data/models/Period.dart';
import 'package:ajent/app/data/models/evaluation.dart';
import 'package:ajent/app/data/services/collection_interface.dart';
import 'package:ajent/app/data/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseService implements CollectionInterface {
  CourseService._privateConstructor();
  static final CourseService instance = CourseService._privateConstructor();

  final FirebaseFirestore database = FirebaseFirestore.instance;

  @override
  String collectionName = 'courses';

  Future<Course> addCourse(Course course) async {
    DocumentReference courseRef =
        await database.collection(collectionName).add(course.toJson());
    course.id = courseRef.id;
    if (course.timeType == TimeType.fixedTime) {
      await courseRef
          .collection('fixedTime')
          .doc('fixedTime')
          .set(course.fixedTime.toJson());
    } else {
      for (var period in course.periods) {
        await courseRef.collection('periods').doc().set(period.toJson());
      }
    }
    return course;
  }

  Future<Course> editCourse(Course course) async {
    await database
        .collection(collectionName)
        .doc(course.id)
        .set(course.toJson(), SetOptions(merge: true));
    if (course.timeType == TimeType.fixedTime) {
      await database
          .collection(collectionName)
          .doc(course.id)
          .collection('fixedTime')
          .doc('fixedTime')
          .set(course.fixedTime.toJson());
    } else {
      final collectionRef = database
          .collection(collectionName)
          .doc(course.id)
          .collection('periods');
      await collectionRef.get().then((value) => value.docs.forEach((element) {
            element.reference.delete();
          }));
      for (var period in course.periods) {
        await database
            .collection(collectionName)
            .doc(course.id)
            .collection('periods')
            .doc()
            .set(period.toJson());
      }
    }
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
    course.getCourseStatus();
    return course;
  }

  Future<List<Course>> getUserLearningCourse(String userUid) async {
    List<Course> courses = [];
    await database
        .collection(collectionName)
        .where('learners', arrayContains: userUid)
        .get()
        .then((value) async {
      for (var element in value.docs) {
        Course course = Course.fromJson(element.id, element.data());
        if (course.timeType == TimeType.fixedTime) {
          await element.reference
              .collection('fixedTime')
              .doc('fixedTime')
              .get()
              .then((value) {
            course.fixedTime = FixedTime.fromJson(value.data());
          });
        } else {
          await element.reference.collection('periods').get().then((value) {
            for (var element in value.docs) {
              course.periods.add(Period.fromJson(element.data()));
            }
            course.periods.sort((a, b) => a.date.compareTo(b.date));
          });
        }
        course.getCourseStatus();
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
        Course course = Course.fromJson(element.id, element.data());
        if (course.timeType == TimeType.fixedTime) {
          await element.reference
              .collection('fixedTime')
              .doc('fixedTime')
              .get()
              .then((value) {
            course.fixedTime = FixedTime.fromJson(value.data());
          });
        } else {
          await element.reference.collection('periods').get().then((value) {
            for (var element in value.docs) {
              course.periods.add(Period.fromJson(element.data()));
            }
            course.periods.sort((a, b) => a.date.compareTo(b.date));
          });
        }
        course.getCourseStatus();
        courses.add(course);
      }
    });
    return courses;
  }

  Future<List<AjentUser>> getLearners(List<String> learnersUid) async {
    List<AjentUser> learners = [];
    for (var learnerUid in learnersUid) {
      AjentUser learner = await UserService.instance.getUser(learnerUid);
      if (learner != null) {
        learners.add(learner);
      }
    }
    return learners;
  }

  Future updateLearnners(Course course) async {
    await database.collection(collectionName).doc(course.id).set({
      'learners': course.learners,
    }, SetOptions(merge: true));
  }

  Future<Map<String, Evaluation>> getEvaluations(String courseId) async {
    Map<String, Evaluation> evaluations = Map();
    await database
        .collection(collectionName)
        .doc(courseId)
        .collection('evaluations')
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        return evaluations;
      }
      for (var item in value.docs) {
        Evaluation evaluation = Evaluation.fromJson(item.id, item.data());
        evaluations[item.id] = evaluation;
      }
    });
    return evaluations;
  }

  Future<Evaluation> postEvaluation(
      String courseId, String user, Evaluation evaluation) async {
    await database
        .collection(collectionName)
        .doc(courseId)
        .collection('evaluations')
        .doc(user)
        .set(evaluation.toJson());
    return evaluation;
  }

  Stream<QuerySnapshot> searchCourse({String keyword, int maxLength = 25}) {
    return database
        .collection(collectionName)
        .where('indexList', arrayContains: keyword)
        .orderBy('name')
        .limit(maxLength)
        .snapshots();
  }
}
