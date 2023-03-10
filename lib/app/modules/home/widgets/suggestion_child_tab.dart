import 'package:ajent/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:odometer/odometer.dart';

class SuggestionChildTab extends StatefulWidget {
  @override
  State<SuggestionChildTab> createState() => _SuggestionChildTabState();
}

class _SuggestionChildTabState extends State<SuggestionChildTab> {
  final HomeController controller = Get.find<HomeController>();

  int totalTutoringHours = 0;
  int tutoredHours = 0;
  int uploadedCount = 0;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        totalTutoringHours = controller.totalTutoringHours.value;
        tutoredHours = controller.tutoredHours.value;
        uploadedCount = controller.uploadedCount.value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28, bottom: 56, left: 16, right: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                '🤓 Your total tutoring hours',
                style: GoogleFonts.nunitoSans(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AnimatedSlideOdometerNumber(
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.fastOutSlowIn,
                    odometerNumber: OdometerNumber(totalTutoringHours),
                    numberTextStyle: GoogleFonts.nunitoSans(
                      fontSize: 64,
                      fontWeight: FontWeight.w900,
                    ),
                    letterWidth: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      ' hours',
                      style: GoogleFonts.nunitoSans(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                '💪 You\'ve tutored for',
                style: GoogleFonts.nunitoSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AnimatedSlideOdometerNumber(
                    duration: const Duration(milliseconds: 1400),
                    curve: Curves.fastOutSlowIn,
                    odometerNumber: OdometerNumber(tutoredHours),
                    numberTextStyle: GoogleFonts.nunitoSans(
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                    ),
                    letterWidth: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      ' hours',
                      style: GoogleFonts.nunitoSans(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                '📌 You\'ve uploaded',
                style: GoogleFonts.nunitoSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AnimatedSlideOdometerNumber(
                    duration: const Duration(milliseconds: 1600),
                    curve: Curves.fastOutSlowIn,
                    odometerNumber: OdometerNumber(uploadedCount),
                    letterWidth: 30,
                    numberTextStyle: GoogleFonts.nunitoSans(
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      ' resources',
                      style: GoogleFonts.nunitoSans(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
