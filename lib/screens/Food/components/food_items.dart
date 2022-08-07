import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';

class FoodItem extends StatelessWidget {
  const FoodItem({
    Key key,
    this.foodItem,
    this.color,
  }) : super(key: key);
  final String foodItem;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Container(
        alignment: Alignment.center,
        height: displayHeight(context) * 0.1,
        width: displayWidth(context) * 0.2,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(60),
        ),
        child: Text(
          foodItem,
          textAlign: TextAlign.center,
          style: kHeading14.copyWith(color: Colors.white),
          
        ),
      ),
    );
  }
}
