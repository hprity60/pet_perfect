import 'package:flutter/material.dart';
import 'package:pet_perfect_app/screens/Food/success.dart';
import 'package:pet_perfect_app/screens/components/default_button.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import '../../screens/Food/components/radio_button.dart';
import 'package:pet_perfect_app/shop/models/shop.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentPage extends StatefulWidget {
  final List<ShopItem> cartItems;
  PaymentPage(this.cartItems);
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: kSecondaryBackgroundColor,
        title: Text(
          'Delivery Address',
          style: kHeading18,
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: kBlackBackgroundColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // height: displayHeight(context) * 0.08,
                width: displayWidth(context) * 0.99,
                decoration: kBox5Decoration(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  // child: Row(
                  //   children: [
                  //     Text(
                  //       'Show Order Details',
                  //       style: kHeading14,
                  //     ),
                  //     Image.asset('assets/images/downward (2).png'),
                  //     Spacer(),
                  //     Text(
                  //       '\$${1500}',
                  //       style: kHeading14,
                  //     ),
                  //   ],
                  // ),
                  child: ExpansionTile(
                    title: Text(
                      'Show Order Details',
                      style: kHeading14,
                    ),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.cartItems.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            // dense: true,
                            visualDensity: VisualDensity.comfortable,
                            title: Text(
                              widget.cartItems[index].title,
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            trailing: Text(
                              widget.cartItems[index].quantity.toString() +
                                  " X " +
                                  " \$" +
                                  widget.cartItems[index].price.toString(),
                              style: kHeading14,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      height: 12,
                      color: kYellowColor,
                    ),
                  ),
                  Positioned(
                    top: -8,
                    left: 27,
                    child: Text(
                      'Delivery within 48 Hours in Delhi NCR',
                      style: kHeading11,
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Payment Mode',
                style: kHeading18,
              ),
              SizedBox(height: 15),
              Container(
                // height: displayHeight(context) * 0.18,
                decoration: kBoxDecoration(),
                child: Column(
                  children: [
                    RadioButton(text: 'UPI'),
                    Divider(),
                    RadioButton(text: 'Cash On Delivery'),
                  ],
                ),
              ),
              SizedBox(height: 60),
              SizedBox(
                height: displayHeight(context) * 0.066,
                width: double.infinity,
                child: DefaultButton(
                  text: "Place Order",
                  textColor: Colors.white,
                  bgColor: kPrimaryColor,
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SuccessPage()));
                  },
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
