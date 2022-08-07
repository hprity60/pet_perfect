import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';

class EmergencyList extends StatelessWidget {
  const EmergencyList({
    Key key,
    this.image,
    this.text,
  }) : super(key: key);
  final String image, text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: displayHeight(context) * .17,
            width: displayWidth(context) * 0.3,
            decoration: kBox55Decoration(),
            child: Image.asset(image),
          ),
          SizedBox(height: 10),
          Text(
            text,
            style: kHeading16,
          ),
        ],
      ),
    );
  }
}
