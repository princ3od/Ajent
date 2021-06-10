import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingPage extends StatelessWidget {
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
            children: [
              Center(
                  child: Row(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(50, 50, 20, 50),
                      child: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/ajent_logo.png"),
                        radius: 40.0,
                      ),
                    ),
                    Text(
                      "My Course Name",
                      style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w700, fontSize: 14),
                    )
                  ])),
              RatingBar.builder(
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemCount: 5,
                initialRating: 4,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemBuilder: (context, index) => Icon(
                  Icons.star_rounded,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                child: TextField(
                  style: GoogleFonts.nunitoSans(),
                  autofocus: true,
                  maxLines: 4,
                  maxLength: 200,
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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: ElevatedButton(
                    style: orangeButtonStyle,
                    child: Text("Đăng tải đánh giá",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w700, fontSize: 14)),
                    onPressed: () {},
                  ),
                ),
              )
            ],
          )),
    );
  }
}
