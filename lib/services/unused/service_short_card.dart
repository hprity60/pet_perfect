//NOT USED

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/utils.dart';

class ServiceShortCard extends StatelessWidget {
  const ServiceShortCard(
      {Key key, this.name, this.rating, this.image, this.distance, this.press})
      : super(key: key);
  final String name, rating, image, distance;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.all(displayWidth(context) * 0.01),
        child: Container(
          decoration: kBoxDecoration(),
          child: Padding(
            padding: EdgeInsets.all(displayWidth(context) * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: displayHeight(context) * 0.115,
                  width: displayWidth(context) * 0.32,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(image),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                // Image.network(
                //   image,
                //   height: displayHeight(context) * 0.03,
                //   width: displayWidth(context) * 0.04,
                // ),
                SizedBox(height: 8),
                Container(
                  width: displayWidth(context) * 0.28,
                  child: Text(
                    name,
                    maxLines: 2,
                    style: kHeading14,
                  ),
                ),

                Expanded(child: SizedBox(height: 4)),
                Row(
                  children: [
                    Text(
                      rating,
                      style: kHeading14,
                    ),
                    Image.asset('assets/images/star.png'),
                    SizedBox(
                      width: displayWidth(context) * 0.05,
                    ),
                    Text(
                      '$distance km',
                      style: kHeading14,
                    ),
                  ],
                ),

                SizedBox(height: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
