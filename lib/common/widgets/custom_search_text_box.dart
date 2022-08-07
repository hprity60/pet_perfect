import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';

class CustomSearchTextBox extends StatefulWidget {
  final String text;
  final Function onPressed;
  final Color textColor;
  final double textSize;
  final Color borderColor;

  const CustomSearchTextBox({
    Key key,
    this.text,
    this.onPressed,
    this.textColor,
    this.borderColor = Colors.black12,
    this.textSize = 14.4,
  }) : super(key: key);
  @override
  _CustomSearchTextBoxState createState() => _CustomSearchTextBoxState();
}

class _CustomSearchTextBoxState extends State<CustomSearchTextBox> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0),
      onPressed: widget.onPressed,
      child: Container(
        width: displayWidth(context),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          // color: Colors.white,
          border: (widget.borderColor != null)
              ? Border.all(
                  color: Colors.black12,
                )
              : null,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.text,
                style: GoogleFonts.poppins(
                  fontSize: widget.textSize,
                  color: widget.textColor,
                ),
              ),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}
