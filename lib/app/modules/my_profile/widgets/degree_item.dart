import 'package:ajent/app/data/models/Degree.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DegreeItem extends StatelessWidget {
  final ValueChanged<Degree> onLongPress;
  final Degree degree;

  const DegreeItem({Key key, @required this.onLongPress, @required this.degree})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Card(
        elevation: 2,
        color: Colors.white,
        child: InkWell(
          onTap: () {
            //
          },
          onLongPress: () {
            onLongPress(degree);
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 10, 15),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(degree.imageUrl),
                backgroundColor: Colors.grey.shade200,
              ),
              title: SizedBox(
                width: Get.width - 100,
                child: Text(degree.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.nunitoSans(
                      fontSize: 16.5,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              subtitle: Text(degree.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.nunitoSans()),
            ),
          ),
        ),
      ),
    );
  }
}
