import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';

class DefaultTextBox extends StatefulWidget {
  final String hintText;
  final String labelText;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final Function onChanged;
  final bool obscureText;
  final bool enabled;

  const DefaultTextBox(
      {Key key,
      this.hintText,
      this.labelText,
      this.textEditingController,
      this.textInputType,
      this.onChanged,
      this.obscureText,
      this.enabled})
      : super(key: key);

  @override
  _DefaultTextBoxState createState() => _DefaultTextBoxState();
}

class _DefaultTextBoxState extends State<DefaultTextBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Container(
        height: displayHeight(context) * 0.065,
        decoration: BoxDecoration(
          color: kTextFieldColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: widget.textEditingController,
          keyboardType: widget.textInputType,
          obscureText: widget.obscureText,
          enabled: widget.enabled == null ? true : widget.enabled,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: secondaryTextColor,
            ),
            prefixIcon: Image.asset(
              'assets/images/food (2).png',
              color: kPrimaryColor,
            ),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,

            contentPadding: EdgeInsets.symmetric(
                horizontal: 20, vertical: displayHeight(context) * 0.02),
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(4)),
            //   borderSide: BorderSide(width: 1, color: Colors.black54),
            // ),
            // disabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(4)),
            //   borderSide: BorderSide(width: 1, color: Colors.grey),
            // ),
            // enabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(4)),
            //   borderSide: BorderSide(width: 1, color: Colors.black12),
            // ),
          ),
        ),
      ),
    );
  }
}
