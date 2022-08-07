import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/utils/utils.dart';

class PrimaryButton extends StatefulWidget {
  final String title;
  final Function onPressed;
  final Widget titleWidget;

  PrimaryButton({
    this.title,
    this.onPressed,
    this.titleWidget,
  });
  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(44),
      ),
      elevation: 0,
      onPressed: widget.onPressed,
      color: kPrimaryColor,
      child: Container(
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.title,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
