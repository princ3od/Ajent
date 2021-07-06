import 'package:ajent/app/data/models/Request.dart';
import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/models/evaluation.dart';
import 'package:ajent/app/data/models/requestCardData.dart';
import 'package:ajent/app/data/models/requestStatusCardData.dart';
import 'package:ajent/app/data/services/collection_interface.dart';
import 'package:ajent/app/data/services/course_service.dart';
import 'package:ajent/app/data/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestService implements CollectionInterface {
  RequestService._privateConstructor();
  static final RequestService instance = RequestService._privateConstructor();

  final FirebaseFirestore database = FirebaseFirestore.instance;

  @override
  String collectionName = 'requests';

  Future<Request> addRequest(Request request) async {
    DocumentReference requestRef =
        await database.collection(collectionName).add(request.toJson());
    request.id = requestRef.id;
    return request;
  }

  Future<List<Request>> getRequestsOf(String user) async {
    List<Request> requests = [];
    await database
        .collection(collectionName)
        .where('requestorUid', isEqualTo: user)
        .get()
        .then((value) {
      for (var item in value.docs) {
        Request request = Request.fromJson(item.id, item.data());
        requests.add(request);
      }
    });
    return requests;
  }

  Future<List<Request>> getRequestsTo(String user) async {
    List<Request> requests = [];
    await database
        .collection(collectionName)
        .where('receiverUid', isEqualTo: user)
        .get()
        .then((value) {
      for (var item in value.docs) {
        Request request = Request.fromJson(item.id, item.data());
        requests.add(request);
      }
    });
    return requests;
  }

  Future<List<String>> getCourseRequestors(String courseId) async {
    List<String> requestorsUid = [];
    await database
        .collection(collectionName)
        .where('courseId', isEqualTo: courseId)
        .get()
        .then((value) {
      for (var item in value.docs) {
        Request request = Request.fromJson(item.id, item.data());
        requestorsUid.add(request.requestorUid);
      }
    });
    return requestorsUid;
  }

  Future<List<RequestCardData>> getRequestItems(String uid) async {
    List<RequestCardData> requestItems = [];
    await database
        .collection(collectionName)
        .where('receiverUid', isEqualTo: uid)
        .orderBy('postDate')
        .orderBy('courseId')
        .get()
        .then((value) async {
      for (var item in value.docs) {
        Request request = Request.fromJson(item.id, item.data());
        Course course =
            await CourseService.instance.getCourse(request.courseId);
        AjentUser requestor =
            await UserService.instance.getUser(request.requestorUid);
        double stars = await getEvaluations(request.requestorUid);

        RequestCardData requestCardData = RequestCardData(
            course: course,
            request: request,
            requestor: requestor,
            star: stars);
        requestItems.add(requestCardData);
      }
    });

    return requestItems;
  }

  Future<double> getEvaluations(String uid) async {
    var averageStar = (-2.0);
    List<Course> teachingCourses = [];
    double totalStar = 0;
    Map<String, Evaluation> evaluations = Map();
    diviceIntoGroup(int star) {
      switch (star) {
        case 5:
          break;
        case 4:
          break;
        case 3:
          break;
        case 2:
          break;
        case 1:
          break;
        default:
          break;
      }
    }

    teachingCourses = await CourseService.instance.getUserTeachingCourse(uid);
    for (var course in teachingCourses) {
      evaluations
          .addAll(await CourseService.instance.getEvaluations(course.id));
    }
    for (var evaluation in evaluations.values) {
      totalStar += evaluation.star;
      diviceIntoGroup(evaluation.star);
    }
    averageStar =
        (evaluations.length > 0) ? (totalStar / evaluations.length) : -1.0;
    return averageStar;
  }

  Future<bool> onDeniedButtonPress(Request requestItem) async {
    bool isSuccess = true;
    await database
        .collection(collectionName)
        .doc('${requestItem.id}')
        .update({'status': 'denied'}).catchError((error) {
      isSuccess = false;
    });
    isSuccess = true;
    return isSuccess;
  }

  Future<bool> onApproveButtonPress(Request requestItem) async {
    bool isSuccess = true;
    await database
        .collection(collectionName)
        .doc('${requestItem.id}')
        .update({'status': 'accepted'}).then((value) async {
      await database
          .collection(collectionName)
          .where('courseId', isEqualTo: requestItem.courseId)
          .get()
          .then((value) async {
        for (var item in value.docs) {
          if (item.id != requestItem.id)
            await database
                .collection(collectionName)
                .doc(item.id)
                .update({'status': 'denied'});
        }
      });
    });
    await database
        .collection('courses')
        .doc('${requestItem.courseId}')
        .update({'teacher': '${requestItem.requestorUid}'});
    isSuccess = true;
    return isSuccess;
  }

  Future<List<RequestStatusCardData>> getRequestStatusItems(String uid) async {
    List<RequestStatusCardData> result = [];
    await database
        .collection(collectionName)
        .where('requestorUid', isEqualTo: uid)
        .get()
        .then((value) async {
      for (var item in value.docs) {
        Request request = Request.fromJson(item.id, item.data());
        Course course =
            await CourseService.instance.getCourse(request.courseId);
        RequestStatusCardData data =
            RequestStatusCardData(course: course, request: request);
        result.add(data);
      }
    });
    return result;
  }

  Future<bool> delRequest(Request item) async {
    bool result = true;
    await database
        .collection(collectionName)
        .doc(item.id)
        .delete()
        .catchError((error) {
      result = false;
    });
    return result;
  }
}
