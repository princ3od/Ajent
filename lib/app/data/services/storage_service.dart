import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:ajent/app/data/services/collection_interface.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class StorageService implements CollectionInterface {
  @override
  String collectionName = 'images';
  StorageService._privateConstructor();
  static final StorageService instance = StorageService._privateConstructor();
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadImage(File image, String uid) async {
    String imageUrl;
    Reference rootStorageReference = storage.ref();
    Reference pictureFolderReference = rootStorageReference
        .child('images')
        .child('$uid/${basename(image.path)}');
    await pictureFolderReference.putFile(image).whenComplete(() async {
      imageUrl = await pictureFolderReference.getDownloadURL();
    });
    return imageUrl;
  }

  Future<String> uploadCourseImage(File image) async {
    String imageUrl;
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference rootStorageReference = storage.ref();
    Reference pictureFolderReference =
        rootStorageReference.child('images').child('coursesImages/$fileName');
    await pictureFolderReference.putFile(image).whenComplete(() async {
      imageUrl = await pictureFolderReference.getDownloadURL();
    }).onError((error, stackTrace) {
      print(error.toString());
      return null;
    });
    return imageUrl;
  }

  Future<String> uploadMessageImage(File image) async {
    String imageUrl;
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference rootStorageReference = storage.ref();
    Reference pictureFolderReference =
        rootStorageReference.child('images').child('messagesImages/$fileName');
    await pictureFolderReference.putFile(image).whenComplete(() async {
      imageUrl = await pictureFolderReference.getDownloadURL();
    }).onError((error, stackTrace) {
      print(error.toString());
      return null;
    });
    return imageUrl;
  }

  Future<String> uploadResource(File image) async {
    String imageUrl;
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    String extension = basename(image.path).split('.').last;
    Reference rootStorageReference = storage.ref();
    Reference pictureFolderReference =
        rootStorageReference.child('resouces').child('$extension/$fileName');
    await pictureFolderReference.putFile(image).whenComplete(() async {
      imageUrl = await pictureFolderReference.getDownloadURL();
    }).onError((error, stackTrace) {
      print(error.toString());
      return null;
    });
    return imageUrl;
  }

  Future<Uint8List> getBytesFromUrl(String url, {name}) async {
    try {
      var data = await http.get(Uri.parse(url));
      var bytes = data.bodyBytes;
      return bytes;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  Future<File> getFileFromUrl(String url, {name}) async {
    var fileName = 'testonline';
    if (name != null) {
      fileName = name;
    }
    try {
      var data = await http.get(Uri.parse(url));
      var bytes = data.bodyBytes;
      Directory tempDir = await getTemporaryDirectory();
      File file = File('${tempDir.path}/$fileName.pdf');
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      print(e);
      throw Exception("Error opening url file");
    }
  }
}
