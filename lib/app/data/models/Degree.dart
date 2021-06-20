import 'package:flutter/cupertino.dart';

class Degree {
  String id;
  String imageUrl;
  String title;
  String description;
  Degree(
      {this.id,
      @required this.imageUrl,
      @required this.title,
      @required this.description});
  Degree.fromJson({@required String id, @required Map<String, dynamic> data}) {
    this.id = id;
    imageUrl = data['imageUrl'];
    title = data['title'];
    description = data['description'];
  }
  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'description': this.description,
      'imageUrl': this.imageUrl,
    };
  }
}
