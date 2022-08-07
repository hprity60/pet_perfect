import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';

class Documents extends StatelessWidget {
  const Documents({
    Key key,
    this.documentImage,
    this.date,
    this.month,
    this.year,
  }) : super(key: key);
  final String documentImage, month;
  final int date, year;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: displayHeight(context) * 0.12,
            width: displayWidth(context) * 0.27,
            // DecorationImage(
            //     image: AssetImage(documentImage),
            //   ),
            //   color: Colors.white,
            //   borderRadius: BorderRadius.circular(5),
            decoration: kBox5Decoration().copyWith(
              image: DecorationImage(
                image: AssetImage(documentImage),
              ),
            ),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 5),
              // GoogleFonts.poppins(
              //       fontSize: 14, fontWeight: FontWeight.w400),
              Text(
                '$date',
                style: kHeading14,
              ),
              SizedBox(width: 5),
              Text(
                month,
                style: kHeading14,
              ),
              SizedBox(width: 5),
              Text(
                '$year',
                style: kHeading14,
              ),
            ],
          )
        ],
      ),
    );
  }
}
