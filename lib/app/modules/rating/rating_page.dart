import 'package:ajent/app/data/models/course.dart';
import 'package:ajent/app/modules/rating/rating_controller.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingPage extends StatelessWidget {
  final Course course = Get.arguments;
  final RatingController controller = Get.put(RatingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Đánh giá",
          style: GoogleFonts.nunitoSans(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.grey[100],
        toolbarHeight: 70,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Hero(
              tag: '${course.id} avatar',
              child: CircleAvatar(
                child: ClipOval(
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/ajent_logo.png',
                    image: course.photoUrl,
                    width: 100,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                radius: 50.0,
              ),
            ),
          ),
          Hero(
            tag: '${course.id} name',
            child: Material(
              color: Colors.transparent,
              child: Text(
                course.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w700, fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 10),
          Obx(
            () => RatingBar.builder(
              ignoreGestures: controller.evaluated.value,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemCount: 5,
              initialRating: (controller.evaluated.value)
                  ? controller.evaluation.star.toDouble()
                  : 0.0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemBuilder: (context, index) => Icon(
                Icons.star_rounded,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                controller.star.value = rating;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: Obx(
              () => TextField(
                enabled: !controller.evaluated.value,
                style: GoogleFonts.nunitoSans(),
                autofocus: false,
                maxLines: 4,
                maxLength: 200,
                controller: controller.contentController,
                decoration: InputDecoration(
                  labelText: "Đánh giá",
                  labelStyle: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.black),
                  hintText: "Hãy để lại phần đánh giá",
                  hintStyle: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => (!controller.evaluated.value)
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: ElevatedButton(
                        style: orangeButtonStyle,
                        child: (controller.isPosting.value)
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : Text("Đăng tải đánh giá",
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700, fontSize: 14)),
                        onPressed: () => controller.postEvaluation(course.id),
                      ),
                    ),
                  )
                : SizedBox(),
          )
        ],
      )),
    );
  }
}
