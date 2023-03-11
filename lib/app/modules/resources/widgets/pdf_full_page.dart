import 'package:ajent/app/data/models/resource.dart';
import 'package:ajent/app/data/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class PdfFullPage extends StatelessWidget {
  const PdfFullPage({Key key, this.resource}) : super(key: key);

  final Resource resource;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(resource.name),
      ),
      body: FutureBuilder(future: () async {
        return await StorageService.instance.getFileFromUrl(resource.url);
      }(), builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return PdfViewer.openFile(snapshot.data.path);
      }),
    );
  }
}
