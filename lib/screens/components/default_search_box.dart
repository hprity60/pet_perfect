import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';

class DefaultSearchBox extends StatelessWidget {
  const DefaultSearchBox(
      {Key key,
      this.hintText,
      this.color,
      this.onEnter,
      this.controller,
      this.onCross})
      : super(key: key);

  final String hintText;
  final Color color;
  final Function onEnter;
  final Function onCross;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: displayHeight(context) * 0.064,
      // height: 36,
      width: displayWidth(context) - 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color != null ? color : kSearchBoxBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        onSubmitted: onEnter,
        autofocus: false,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.green,
          ),
          hintText: hintText,
          suffixIcon: GestureDetector(
              onTap: onCross,
              child: Icon(
                Icons.close,
                color: Colors.red,
              )),
          hintStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          focusColor: Colors.black,
          contentPadding: EdgeInsets.symmetric(vertical: 16),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
