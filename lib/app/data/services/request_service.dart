import 'package:ajent/app/data/models/Request.dart';
import 'package:ajent/app/data/models/ajent_user.dart';
import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/data/models/requestCardData.dart';
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
        .get()
        .then((value) async {
      for (var item in value.docs) {
        Request request = Request.fromJson(item.id, item.data());
        Course course =
            await CourseService.instance.getCourse(request.courseId);
        AjentUser requestor =
            await UserService.instance.getUser(request.requestorUid);
        RequestCardData requestCardData = RequestCardData(
            course: course, request: request, requestor: requestor);
        requestItems.add(requestCardData);
      }
    });

    return requestItems;
  }
}
