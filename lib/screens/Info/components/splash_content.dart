import 'package:flutter/material.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.text1,
    this.text2,
  }) : super(key: key);
  final String text1, text2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text1,
          style: kHeading16.copyWith(fontWeight: FontWeight.w600),
          softWrap: true,
        ),
        SizedBox(height: 16),
        Text(
          text2,
          style: kHeading14,
          softWrap: true,
        ),
      ],
    );
  }
}
