import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/screens/components/default_button.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';

class RecordLists extends StatelessWidget {
  const RecordLists({
    Key key,
    this.title,
    this.image,
    this.date,
    this.press,
  }) : super(key: key);
  final String title, image;
  final String date;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: kHeading16,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: kBox55Decoration(color: kPrimaryColor).copyWith(
                      border: Border.all(
                        color: kPrimaryColor,
                      ),
                    ),
                    child: Image.asset(image),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Updated required ',
                        style: kHeading14.copyWith(color: kredBackgroundColor),
                        //color: Colors.red),
                      ),
                      SizedBox(height: 14),
                      Text(
                        'Last updated on\n02 Dec 2020',
                        style: kHeading14.copyWith(color: kPrimaryColor),
                        //color: kPrimaryColor,
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  DefaultButton(
                    bgColor: kPrimaryColor,
                    textColor: kWhiteBackgroundColor,
                    press: () {},
                    text: 'Update',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
