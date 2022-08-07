import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';

class RadioButton extends StatelessWidget {
  const RadioButton({
    Key key,
    this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Icon(Icons.radio_button_off_outlined),
          SizedBox(width: 20),
          Text(
            text,
            style: kHeading14,
          ),
        ],
      ),
    );
  }
}
