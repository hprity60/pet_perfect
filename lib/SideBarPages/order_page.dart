import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/SideBarPages/components/order_lists.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCustomWhiteColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'My Orders',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  OrderLists(
                    image: 'assets/images/product1.png',
                    date: 2,
                    productDetail:
                        'Royal Canin Maxi Breed \nAdult Dry Dog Food',
                  ),
                  SizedBox(height: 8),
                  OrderLists(
                    image: 'assets/images/product1.png',
                    date: 4,
                    productDetail:
                        'Royal Canin Maxi Breed \nAdult Dry Dog Food',
                  ),
                  SizedBox(height: 8),
                  OrderLists(
                    image: 'assets/images/product1.png',
                    date: 6,
                    productDetail:
                        'Royal Canin Maxi Breed \nAdult Dry Dog Food',
                  ),
                  SizedBox(height: 8),
                  OrderLists(
                    image: 'assets/images/product1.png',
                    date: 4,
                    productDetail:
                        'Royal Canin Maxi Breed \nAdult Dry Dog Food',
                  ),
                  SizedBox(height: 8),
                  OrderLists(
                    image: 'assets/images/product1.png',
                    date: 6,
                    productDetail:
                        'Royal Canin Maxi Breed \nAdult Dry Dog Food',
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
