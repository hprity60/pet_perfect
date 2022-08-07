import 'package:flutter/material.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';

class ChooseImages extends StatelessWidget {
  const ChooseImages({
    Key key,
    this.img,
    this.text,
  }) : super(key: key);
  final String img, text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: displayHeight(context) * 0.2,
      width: displayWidth(context) * 0.28,
      decoration: kBox5Decoration(),
      child: Container(
        height: displayHeight(context) * 0.2,
        width: displayWidth(context) * 0.28,
        child: Column(
          children: [
            Image.asset(img),
            Text(
              text,
              style: kHeading14,
            ),
          ],
        ),
      ),
    );
  }
}
