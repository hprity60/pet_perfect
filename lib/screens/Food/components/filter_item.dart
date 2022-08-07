import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';

class FilterItem extends StatelessWidget {
  const FilterItem({
    Key key,
    this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: kHeading14,
        ),
        Spacer(),
        Icon(Icons.add),
      ],
    );
  }
}
