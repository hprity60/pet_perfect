import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';

class DietLists extends StatelessWidget {
  const DietLists({
    Key key,
    this.foodName,
    this.foodQuantity,
    this.index,
  }) : super(key: key);
  final String foodName, foodQuantity;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            foodName,
            style: kHeading16,
          ),
          Text(
            foodQuantity,
            style: kHeading16,
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: kPrimaryColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
