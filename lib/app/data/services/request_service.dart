import 'package:ajent/app/data/models/Request.dart';
import 'package:ajent/app/data/services/collection_interface.dart';
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
}
