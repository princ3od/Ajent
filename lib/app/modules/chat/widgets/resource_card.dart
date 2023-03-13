import 'package:ajent/app/data/models/resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:thumbnailer/thumbnailer.dart';

import '../../../../core/utils/date_converter.dart';
import '../../../data/services/resource_service.dart';
import '../../../data/services/storage_service.dart';
import '../../resources/widgets/pdf_full_page.dart';
import 'full_image_page.dart';

class ResourceCard extends StatelessWidget {
  ResourceCard({Key key, @required this.resourceId}) : super(key: key);

  final String resourceId;

  _getResource() async {
    return await ResourceService.instance.getResourceById(resourceId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.7,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: FutureBuilder(
          future: _getResource(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Resource resource = snapshot.data;
              return InkWell(
                onTap: () async {
                  if (resource.fileType == 'pdf') {
                    Get.to(() => CupertinoScaffold(
                          body: PdfFullPage(resource: resource),
                        ));
                  } else {
                    Get.to(
                      () => CupertinoScaffold(
                        body: FullImageScreen(
                          imageURL: resource.url,
                          name: resource.name,
                          showShareButton: true,
                          resource: resource,
                        ),
                      ),
                    );
                  }
                },
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 400),
                  opacity: (resource != null) ? 1 : 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        child: Thumbnail(
                          dataResolver: () async {
                            return await StorageService.instance
                                .getBytesFromUrl(resource.url);
                          },
                          mimeType: (resource.fileType == 'pdf')
                              ? 'application/pdf'
                              : 'image',
                          widgetSize: Get.width * 0.7,
                          errorBuilder: (context, error) {
                            return Center(
                              child: Text('Error: $error'),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name: ${resource.name}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.upload,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  DateConverter.getTimeInAgo(resource
                                      .createdAt.millisecondsSinceEpoch),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.file_present,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  resource.fileType,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
