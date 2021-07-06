import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
class RatingOverall extends StatelessWidget {
  final double averageStar;
  final int total;
  final double star5, star4, star3, star2, star1;

  RatingOverall({
    @required this.averageStar,
    @required this.total,
    @required this.star5,
    @required this.star4,
    @required this.star3,
    @required this.star2,
    @required this.star1,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 20),
        Column(
          children: [
            Text(
              averageStar.toStringAsFixed(2),
              style: GoogleFonts.nunitoSans(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            RatingBar.builder(
              itemSize: 18,
              ignoreGestures: true,
              itemCount: 5,
              initialRating: 5,
              itemBuilder: (context, index) => Icon(
                Icons.star_rounded,
                color: Colors.amber,
              ),
              onRatingUpdate: (value) {},
            ),
            Text(
              '$total '+"ratings".tr,
              style: GoogleFonts.nunitoSans(fontSize: 12),
            ),
          ],
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RatingLine(star: 5, value: star5, color: Colors.green),
              RatingLine(star: 4, value: star4, color: Colors.lime),
              RatingLine(star: 3, value: star3, color: Colors.yellow),
              RatingLine(star: 2, value: star2, color: Colors.orange),
              RatingLine(star: 1, value: star1, color: Colors.red),
            ],
          ),
        ),
      ],
    );
  }
}

class RatingLine extends StatelessWidget {
  final int star;
  final double value;
  final Color color;
  const RatingLine({
    Key key,
    @required this.star,
    @required this.value,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(star.toString(), style: GoogleFonts.nunitoSans(fontSize: 12)),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 20),
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              value: value,
            ),
          ),
        ),
      ],
    );
  }
}
