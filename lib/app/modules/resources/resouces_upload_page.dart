import 'package:ajent/app/modules/resources/resources_controller.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thumbnailer/thumbnailer.dart';

class ResourcesUploadPage extends StatelessWidget {
  final controller = Get.find<ResoucesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteAccentColor,
        title: Text(
          'Upload resources',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          controller.hasFile.value = false;
          controller.file = null;
          controller.nameController.clear();
          controller.descriptionController.clear();
          controller.isUploading.value = false;
          return true;
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OutlinedButton(
                  onPressed: () {
                    controller.pickFile();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.folder_open, size: 24),
                      SizedBox(width: 10),
                      Text('Choose file', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                  child: Text('Preview', style: TextStyle(fontSize: 20)),
                ),
                Obx(
                  () => AnimatedOpacity(
                    opacity: controller.hasFile.value ? 1 : 0,
                    duration: Duration(milliseconds: 300),
                    child: Card(
                      elevation: 2,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: controller.hasFile.value
                            ? Thumbnail(
                                dataResolver: () async {
                                  if (controller.hasFile.value) {
                                    return controller.file?.readAsBytesSync();
                                  }
                                  return null;
                                },
                                mimeType:
                                    (controller.file?.path?.isPDFFileName ??
                                            false)
                                        ? 'application/pdf'
                                        : 'image',
                                widgetSize: Get.width - 32,
                                errorBuilder: (context, error) {
                                  return Center(
                                    child: Text('Error: $error'),
                                  );
                                },
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, bottom: 4.0),
                                child: Text('No file selected'),
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    labelText: 'Resource name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: controller.descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Resource description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.upload(context);
                    },
                    child: Obx(
                      () => controller.isUploading.value
                          ? SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.cloud_upload, size: 24),
                                SizedBox(width: 10),
                                Text('Upload', style: TextStyle(fontSize: 16)),
                              ],
                            ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
