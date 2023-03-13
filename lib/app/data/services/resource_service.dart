import 'package:ajent/app/data/services/collection_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/resource.dart';

class ResourceService implements CollectionInterface {
  ResourceService._privateConstructor();
  static final ResourceService instance = ResourceService._privateConstructor();

  @override
  String collectionName = 'resources';

  final FirebaseFirestore database = FirebaseFirestore.instance;

  Future<Resource> createResouce(Resource resource) async {
    DocumentReference documentReference =
        await database.collection(collectionName).add(resource.toJson());
    await database.collection("users").doc(resource.owner).update({
      "uploadedResourceCount": FieldValue.increment(1),
    });
    return resource.copyWith(id: documentReference.id);
  }

  Future<List<Resource>> getResourcesOfUser(String uid) async {
    QuerySnapshot querySnapshot = await database
        .collection(collectionName)
        .where('owner', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .get();
    if (querySnapshot.docs.isEmpty) return [];
    return querySnapshot.docs
        .map((e) => Resource.fromJson(e.id, e.data()))
        .toList();
  }

  Future<Resource> getResourceById(String id) async {
    DocumentSnapshot documentSnapshot =
        await database.collection(collectionName).doc(id).get();
    if (!documentSnapshot.exists) return null;
    return Resource.fromJson(documentSnapshot.id, documentSnapshot.data());
  }
}
