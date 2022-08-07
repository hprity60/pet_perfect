import 'package:flutter/material.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key key,
    this.productImage,
    this.title,
    this.price,
    this.press,
    this.addToCart,
  }) : super(key: key);
  final String productImage, title;
  final double price;
  final Function press;
  final Function addToCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWhiteBackgroundColor,
      height: displayHeight(context) * 0.45,
      width: displayWidth(context) * 0.9,
      child:
       Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: press,
              child: Container(
                // height: displayHeight(context) * 0.25,
                // width: displayWidth(context) * 0.9,
                child: Image.network(productImage),
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: kHeading14,
            ),
            SizedBox(height: 8),

            Text(
              '\$ ${price}',
              textAlign: TextAlign.center,
              style: kHeading14,
            ),
            
            Container(
              width: double.infinity,
              child: FlatButton(
                  color: Colors.black,
                  onPressed: addToCart,
                  child: Text(
                    'Add to Cart',
                    style: kHeading14.copyWith(
                        color: kWhiteBackgroundColor),
                  )),
            ),

            
          ],
        ),
      ),
      // ),
    );
  }
}
