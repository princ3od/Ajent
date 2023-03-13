import 'package:ajent/app/data/models/resource.dart';
import 'package:ajent/app/data/services/storage_service.dart';
import 'package:ajent/app/modules/chat/widgets/full_image_page.dart';
import 'package:ajent/app/modules/resources/resources_controller.dart';
import 'package:ajent/app/modules/resources/widgets/pdf_full_page.dart';
import 'package:ajent/core/utils/date_converter.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:thumbnailer/thumbnailer.dart';

class ResoucesTab extends StatelessWidget {
  final ResoucesController controller = Get.put(ResoucesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(Routes.resourcesUpload);
        },
        tooltip: 'Increment',
        label: Text('Upload new resource +'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
        child: Column(
          children: [
            const SizedBox(height: 4),
            Text(
              'Resources'.tr,
              style: GoogleFonts.nunitoSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: Obx(
                () => SmartRefresher(
                  physics: BouncingScrollPhysics(),
                  controller: controller.refreshController,
                  onRefresh: () async {
                    await controller.fetchResources();
                  },
                  child: (controller.resouces.length > 0)
                      ? ListView.separated(
                          itemCount: controller.resouces.length,
                          separatorBuilder: (context, index) {
                            return const Divider(
                              indent: 16,
                              endIndent: 20,
                              height: 1,
                              thickness: 1,
                            );
                          },
                          itemBuilder: (context, index) {
                            final Resource resource =
                                controller.resouces[index];
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              horizontalTitleGap: 12,
                              onTap: () {
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
                              leading: Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
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
                                  widgetSize: 90,
                                  errorBuilder: (context, error) {
                                    return Center(
                                      child: Text('Error: $error'),
                                    );
                                  },
                                ),
                              ),
                              title: Text(
                                resource.name.capitalizeFirst,
                                style: GoogleFonts.nunitoSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Uploaded '.tr +
                                    DateConverter.getTimeInAgo(resource
                                        .createdAt.millisecondsSinceEpoch) +
                                    ' • ${resource.fileType.capitalize} file',
                                style: GoogleFonts.nunitoSans(
                                  fontSize: 12,
                                ),
                              ),
                            );
                          },
                        )
                      : AnimatedOpacity(
                          opacity: (controller.resouces.length > 0 ||
                                  controller.isUploading.value)
                              ? 0
                              : 1,
                          duration: Duration(milliseconds: 500),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxWidth: Get.width - 100,
                                          maxHeight: Get.width - 100,
                                        ),
                                        child: Image.asset(
                                          'assets/images/empty_resouces.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Hey! Start upload now. 🗃️'.tr,
                                        style: GoogleFonts.nunitoSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "All of uploaded resouces will be shown here."
                                            .tr,
                                        style: GoogleFonts.nunitoSans(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: SizedBox(),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
