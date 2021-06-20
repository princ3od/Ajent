import 'package:ajent/core/values/colors.dart';
import 'package:ajent/routes/pages.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TeachingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          elevation: 2,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [primaryColor, Color.fromARGB(255, 255, 128, 64)])),
            child: InkWell(
                onTap: () {
                  Get.toNamed(Routes.MYTEACHINGDETAIL);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Row(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/ajent_logo.png"),
                          radius: 40.0,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "My Teaching Name",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                      )
                    ]))
                  ],
                )),
          )),
    );
  }
}
