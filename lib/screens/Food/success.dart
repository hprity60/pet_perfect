import 'dart:ui';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:flutter/material.dart';
import 'package:pet_perfect_app/screens/components/default_button.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';

class SuccessPage extends StatefulWidget {
  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Image.asset('assets/images/success.png'),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    'success!',
                    style: kHeading18,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Your order will be delivered soon. Thank you for choosing our app!',
                    textAlign: TextAlign.center,
                    style: kHeading14,
                  ),
                  SizedBox(height: 60),
                  SizedBox(
                    height: displayHeight(context) * 0.066,
                    width: double.infinity,
                    child: DefaultButton(
                      text: "Continue Shopping",
                      textColor: kWhiteBackgroundColor,
                      bgColor: kPrimaryColor,
                      press: () {},
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Return to Home',
                    style: kHeading14,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
