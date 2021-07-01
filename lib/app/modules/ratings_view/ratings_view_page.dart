import 'package:ajent/app/modules/ratings_view/widgets/a_rating_card.dart';
import 'package:ajent/app/modules/ratings_view/widgets/rating_overall.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../profile_view/profile_view_controller.dart';
import 'widgets/a_rating_card.dart';
import 'ratings_view_controller.dart';

class RatingsViewPage extends StatelessWidget {
  final RatingViewController controller = Get.put(RatingViewController());
  final ProfileViewController _profileViewController =
      Get.find<ProfileViewController>();

  @override
  Widget build(BuildContext context) {
    final double averageStar = _profileViewController.averageStar.value;
    final int total = _profileViewController.evaluations.length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
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
          RatingOverall(
            averageStar: averageStar,
            total: total,
            star1: _profileViewController.total1 / total,
            star2: _profileViewController.total2 / total,
            star3: _profileViewController.total3 / total,
            star4: _profileViewController.total4 / total,
            star5: _profileViewController.total5 / total,
          ),
          Divider(
            thickness: 0.8,
          ),
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
