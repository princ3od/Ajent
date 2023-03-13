import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:photo_view/photo_view.dart';

import '../../../data/models/resource.dart';
import '../../resources/resources_share_page.dart';

class FullImageScreen extends StatelessWidget {
  final String imageURL;
  final String name;
  final String tag;
  final bool showShareButton;
  final Resource resource;

  FullImageScreen({
    @required this.imageURL,
    @required this.name,
    this.tag = "",
    this.showShareButton = false,
    this.resource,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text("$name"),
        backgroundColor: Colors.transparent,
        actions: [
          if (showShareButton)
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                CupertinoScaffold.showCupertinoModalBottomSheet(
                  context: context,
                  builder: (context) => ResourceSharePage(
                    resource: resource,
                  ),
                );
              },
            )
        ],
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
    );
  }
}
