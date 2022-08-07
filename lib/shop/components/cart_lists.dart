import 'package:flutter/material.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';

class CartLists extends StatelessWidget {
  const CartLists({
    Key key,
    this.text,
    this.image,
    this.price,
  }) : super(key: key);
  final String text, image;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: displayHeight(context) * 0.21,
      width: displayWidth(context) * 0.99,
      decoration: kBoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.network(
                  image,
                  width: 64,
                  height: 64,
                ),
                SizedBox(width: 10),
                Text(
                  text,
                  style: kHeading14,
                ),
                Spacer(),
                InkWell(child: Image.asset('assets/images/cancel.png')),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.remove),
                SizedBox(
                  height: displayHeight(context) * .035,
                  width: displayWidth(context) * 0.09,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.5)),
                    child: Text(
                      '1',
                      style: kHeading14,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Icon(Icons.add),
                Spacer(),
                Text(
                  '\$$price',
                  style: kHeading14,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
