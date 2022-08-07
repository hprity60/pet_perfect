import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';

class ProfileBioList extends StatelessWidget {
  const ProfileBioList({
    Key key,
    this.text1,
    this.text2,
    this.isEditable,
    this.textEditingController,
  }) : super(key: key);
  final String text1, text2;
  final TextEditingController textEditingController;
  final bool isEditable;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: TextField(
            controller: textEditingController,
            enabled: isEditable,
            autofocus: false,
            decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 8),
              labelText: text1,
              labelStyle: GoogleFonts.poppins(
                  color: Colors.black38, fontSize: 13, fontWeight: FontWeight.w400,),
            ),
          ),
        ),
        Divider(color: Colors.black12,)
      ],
    );
  }
}
