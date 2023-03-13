import 'package:ajent/app/data/models/resource.dart';
import 'package:ajent/app/data/services/storage_service.dart';
import 'package:ajent/app/modules/resources/resources_share_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class PdfFullPage extends StatelessWidget {
  const PdfFullPage({Key key, this.resource}) : super(key: key);

  final Resource resource;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(resource.name),
        actions: [
          IconButton(
            icon: Icon(Icons.copy),
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: resource.url));
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Copied')));
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () async {
              CupertinoScaffold.showCupertinoModalBottomSheet(
                context: context,
                builder: (context) => ResourceSharePage(
                  resource: resource,
                ),
              );
            },
          ),
        ],
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
