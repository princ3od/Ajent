import 'package:ajent/core/values/colors.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class MemberCard extends StatelessWidget {
  final String memberName;
  final String shortBio;
  final String img;
  final String github;
  final String facebook;
  final String studentId;
  final String quotes;
  const MemberCard({
    Key key,
    @required this.img,
    @required this.memberName,
    @required this.shortBio,
    @required this.github,
    @required this.facebook,
    @required this.studentId,
    @required this.quotes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      back: Card(
        elevation: 1.6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: whiteAccentColor,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  quotes,
                  maxLines: 8,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunitoSans(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '#$studentId',
                  style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      front: Card(
        elevation: 1.6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: whiteAccentColor,
        child: Container(
          width: Get.width * 0.75,
          height: 150,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                  ))),
                  Expanded(flex: 2, child: Container()),
                ],
              ),
              Column(
                children: [
                  Spacer(
                    flex: 9,
                  ),
                  Center(
                    child: CircleAvatar(
                      child: ClipOval(
                        child: Image.asset(
                          img,
                          fit: BoxFit.fitWidth,
                          width: 64,
                          height: 64,
                        ),
                      ),
                      radius: 32.0,
                    ),
                  ),
                  SizedBox(height: 5),
                  Material(
                    color: Colors.transparent,
                    child: Text(
                      memberName,
                      style: GoogleFonts.nunitoSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Text(
                      shortBio,
                      style: GoogleFonts.nunitoSans(
                        color: Colors.black.withOpacity(0.4),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            launch("https://github.com/$github");
                          },
                          icon: SizedBox(
                              height: 20,
                              width: 20,
                              child: Image.asset('assets/images/github.png'))),
                      SizedBox(width: 10),
                      IconButton(
                          onPressed: () {
                            launch("https://facebook.com/$facebook");
                          },
                          icon: SizedBox(
                              height: 20,
                              width: 20,
                              child:
                                  Image.asset('assets/images/facebook.png'))),
                    ],
                  ),
                  Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
