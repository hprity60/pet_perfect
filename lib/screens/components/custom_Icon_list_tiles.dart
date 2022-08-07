import 'package:flutter/material.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';

class CustomIconListTile extends StatelessWidget {
  const CustomIconListTile({
    Key key,
    this.icon,
    this.text,
    this.color,
    this.press,
  }) : super(key: key);
  final String icon, text;
  final Color color;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        child: Row(
          children: [
            SizedBox(width: 20),
            Image.asset(icon),
            SizedBox(width: 20),
            Text(
              text,
              style: kHeading16,
            ),
          ],
        ),
      ),
    );
  }
}
