import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';

class ChoosePet extends StatelessWidget {
  ChoosePet({
    Key key,
    this.image,
    this.petName,
  }) : super(key: key);
  final String image, petName;
  Color focusColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 130,
      // width: 130,
      width: displayWidth(context) * 0.34,
      decoration: kBox20Decoration(),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Image.asset(
              image,
            ),
            SizedBox(height: 10),
            Text(
              petName,
              style: kHeading16.copyWith(color: kPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
