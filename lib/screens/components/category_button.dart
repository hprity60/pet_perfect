import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    Key key,
    this.text,
    this.textColor,
    this.bgColor,
    this.press,
    this.size,
  }) : super(key: key);
  final String text;
  final Color textColor, bgColor;
  final Function press;
  final double size;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      height: size,
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
            fontSize: 14, color: textColor, fontWeight: FontWeight.w400),
      ),
      onPressed:press,
    );
  }
}
