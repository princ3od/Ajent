import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullImageScreen extends StatelessWidget {
  final String imageURL;
  final String name;
  final String tag;
  FullImageScreen(
      {@required this.imageURL, @required this.name, this.tag = ""});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text("$name"),
              backgroundColor: Colors.transparent,
            ),
            body: SafeArea(
              child: Hero(
                tag: (tag.isEmpty) ? imageURL : tag,
                child: PhotoView(
                  initialScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 1.0,
                  imageProvider: NetworkImage(imageURL),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
