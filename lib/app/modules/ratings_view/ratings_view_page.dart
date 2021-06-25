import 'package:ajent/app/modules/ratings_view/a_rating_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import 'a_rating_card.dart';
import 'ratings_view_controller.dart';

class RatingsViewPage extends StatelessWidget {
  final RatingViewController controller = Get.put(RatingViewController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.grey[100],
        toolbarHeight: 70.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "see_ratings_label".tr,
          style: GoogleFonts.nunitoSans(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                controller: controller.scrollControler,
                itemCount: controller.evaluations.length +
                    ((controller.isLoading.value) ? 3 : 0),
                itemBuilder: (context, index) {
                  if (index > controller.evaluations.length - 1)
                    return ProfileShimmer();
                  return ARatingCard(
                    user: controller
                        .users[controller.evaluations[index].evaluatorUid],
                    evaluation: controller.evaluations[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
