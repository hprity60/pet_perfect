import 'package:flutter/material.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';

class RegistrationCard extends StatelessWidget {
  const RegistrationCard({
    Key key,
    this.image,
    this.petName,
    this.ownerName,
    this.registrationId,
  }) : super(key: key);
  final String image, petName, ownerName, registrationId;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: displayHeight(context) * 0.21,
        width: double.infinity,
        decoration: kBoxDecoration(),
        // BoxDecoration(
        //   borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    image,
                    width: displayWidth(context) * 0.2,
                    height: displayHeight(context) * 0.14,
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        petName,
                        style: kHeading16,
                      ),
                      Text(
                        registrationId,
                        style: kHeading16,
                      ),
                      Text(
                        ownerName,
                        style: kHeading16,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
