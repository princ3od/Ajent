import 'package:ajent/app/modules/about/member_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var members = <Map<String, String>>[
      {
        'name': 'Dr. Fawaz A. Mereani',
        'bio': 'Assistant Professor of Information Security',
        'img': 'assets/images/FM.jpg',
        'github': 'fmereani',
        'facebook': 'Fawaz Mereani',
        'id': '1',
        'quote':
            '"Don\'t cry because it\'s over smile because it happened" - Dr. Seuss',
      },
      {
        'name': 'Dương Bình Trọng',
        'bio': 'Intern at Tisoha',
        'img': 'assets/images/trong.jpg',
        'github': 'princ3od',
        'facebook': 'princ3od',
        'id': '2',
        'quote': '"Life is not fair; get used to it." - Bill Gates',
      },
      {
        'name': 'Toleen F. Mereani',
        'bio': 'AlBatool Student',
        'img': 'assets/images/default_avatar_female.png',
        //'github': 'Duc-Hoang-UIT',
        //'facebook': 'JameBorn.N0',
        'id': '3',
        'quote': 'Being on the edge is worth the view',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Get.back()),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                child: Image.asset("assets/images/ajent_logo.png"),
                width: 100,
                height: 100,
              ),
              Material(
                color: Colors.transparent,
                child: Text(
                  "Tutor Time",
                  style: GoogleFonts.suezOne(
                    fontSize: 32,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: Text(
                  "Move forward",
                  style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Material(
                color: Colors.transparent,
                child: Text(
                  'About'.tr,
                  style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.75,
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    'Tutor Time is an app bridges the gap between Tutors and Learners.'
                        .tr
                        .tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        launch("https://github.com/fmereani");
                      },
                      icon: Image.asset('assets/images/github.png')),
                  SizedBox(width: 10),
                  IconButton(
                      onPressed: () {
                        showAboutDialog(
                          context: context,
                          applicationVersion: '1.0.0',
                          applicationIcon: Container(
                            child: Image.asset("assets/images/ajent_logo.png"),
                            width: 50,
                            height: 50,
                          ),
                          applicationLegalese: 'Copyright 2023 Tutor Time',
                          children: [
                            SizedBox(height: 10),
                            Text("Tutor searching app"),
                          ],
                        );
                      },
                      icon: Image.asset('assets/images/license.png')),
                ],
              ),
              SizedBox(height: 20),
              Material(
                color: Colors.transparent,
                child: Text(
                  'Our team'.tr,
                  style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 5),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayAnimationDuration: Duration(seconds: 1),
                ),
                items: members.map((member) {
                  return Builder(
                    builder: (BuildContext context) {
                      return MemberCard(
                        facebook: member['facebook'],
                        github: member['github'],
                        img: member['img'],
                        shortBio: member['bio'],
                        memberName: member['name'],
                        quotes: member['quote'],
                        studentId: member['id'],
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text(
                "© Tutor Time 2023",
                style: GoogleFonts.nunitoSans(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
