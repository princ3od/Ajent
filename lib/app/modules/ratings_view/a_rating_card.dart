import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class ARatingCard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      shadowColor: Colors.grey[100],
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: CircleAvatar(
              backgroundImage:
              AssetImage("assets/images/ajent_logo.png"),
              radius: 40.0,
            ),
          ),
          Flexible(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Christine Harisson",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w700, fontSize: 14,color: Colors.black),
                    ),
                    RatingBar.builder(
                      itemSize: 15,
                      ignoreGestures: true,
                      itemCount: 5,
                      initialRating: 4,
                      itemBuilder: (context, index) => Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                      ),
                    ),
                    Text("Teacher was petty good :))",style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w400),),
                  ]
              ))
        ],
      ),
    );
  }
}