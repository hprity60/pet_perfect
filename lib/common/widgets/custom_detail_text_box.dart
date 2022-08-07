import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';

class CustomDetailTextBox extends StatefulWidget {
  // final String hintText;
  final String labelText;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final Function onChanged;
  final bool obscureText;
  final bool enabled;

  const CustomDetailTextBox({
    Key key,
    // this.hintText,
    this.labelText,
    this.textEditingController,
    this.textInputType,
    this.onChanged,
    this.obscureText,
    this.enabled,
  }) : super(key: key);

  @override
  _CustomDetailTextBoxState createState() => _CustomDetailTextBoxState();
}

class _CustomDetailTextBoxState extends State<CustomDetailTextBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      child: Container(
        // height: 52,
        height: displayHeight(context) * 0.068,
        // width: 282,
        width: displayWidth(context) * 0.4,
        decoration: kBoxDecoration(),
        child: TextField(
          controller: widget.textEditingController,
          keyboardType: widget.textInputType,
          obscureText: widget.obscureText,
          enabled: widget.enabled == null ? true : widget.enabled,
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: kHeading16.copyWith(color: kPrimaryColor,height: 1),

            focusedBorder: InputBorder.none,

            enabledBorder: InputBorder.none,
            border: InputBorder.none,

            contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 12),
           
          ),
        ),
      ),
    );
  }
}
