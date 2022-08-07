import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/common/widgets/loading_indicator.dart';
import 'package:pet_perfect_app/screens/Food/bloc/food_bloc.dart';
import 'package:pet_perfect_app/screens/Food/bloc/food_event.dart';
import 'package:pet_perfect_app/screens/Food/bloc/food_state.dart';
import 'package:pet_perfect_app/screens/Food/models/food.dart';
import 'package:pet_perfect_app/screens/Food/nutritions_guide.dart';
import 'package:pet_perfect_app/screens/components/side_bar.dart';
import 'package:pet_perfect_app/screens/Food//refill_tracker.dart';
import 'package:pet_perfect_app/shop/bloc/shop_bloc.dart';
import 'package:pet_perfect_app/shop/view/product_page.dart';
import 'package:pet_perfect_app/shop/view/shopping_cart.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({Key key}) : super(key: key);
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  RefillFood refillFood;
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    bool loadingData = true;

    return BlocListener<FoodBloc, FoodState>(
      listener: (context, state) {
        if (state is GetRefillDataLoadingState) {
          loadingData = true;
        }
        if (state is GetRefillDataLoadedState) {
          loadingData = false;
          refillFood = state.refillFood;
        }
      },
      child: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          return Scaffold(
            drawer: SideBar(),
            appBar: AppBar(
              toolbarHeight: 56,
              title: Text(
                "Pet Perfect",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              elevation: 0,
              backgroundColor: kPrimaryColor,
              actions: [
                IconButton(
                  icon: Image.asset(
                    'assets/images/notification.png',
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            // backgroundColor: kPrimaryColor,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        // height: displayHeight(context)*1.02,
                        width: double.infinity,
                        decoration: kBackgroundBoxDecoration(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Food Store",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              SizedBox(height: fitToHeight(16, context)),
                              _buildGoToCarButton(),
                              SizedBox(height: fitToHeight(16, context)),
                              // Container(
                              //   height: fitToHeight(260, context),
                              //   width: double.infinity,

                              //   child: PageView.builder(
                              //       onPageChanged: (value) {
                              //         setState(() {
                              //           currentPage = value;
                              //         });
                              //       },
                              //       itemCount: 3,
                              //       itemBuilder: (context, index) {
                              //         return Image.asset(
                              //             'assets/images/banner.png');
                              //       }),
                              // ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => BlocProvider(
                                              create: (context) => ShopBloc(),
                                              child: ProductPage())));
                                },
                                child: Container(
                                  // height: displayHeight(context) * 0.24,
                                  height: fitToHeight(220, context),
                                  width: displayWidth(context),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            'assets/images/banner.png')),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              // SizedBox(height: fitToHeight(8, context)),

                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: List.generate(
                              //     3,
                              //     (index) => builsDot(index: index),
                              //   ),
                              // ),
                              SizedBox(height: fitToHeight(24, context)),
                              Text(
                                "Food Monitoring",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: fitToHeight(16, context)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  BlocProvider.value(
                                                      value: BlocProvider.of<
                                                          FoodBloc>(context)
                                                        ..add(
                                                            GetFoodDataEvent()),
                                                      child:
                                                          NutritionsGuide())));
                                    },
                                    child: Container(
                                      height: MediaQuery.of(context)
                                              .devicePixelRatio *
                                          65,
                                      width: displayWidth(context) * 0.5 - 24,
                                      // decoration: BoxDecoration(
                                      //   // color: Color(0xFFFFFFFF),
                                      //   borderRadius: BorderRadius.circular(16),
                                      // ),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                child: Text(
                                                  'Nutrition \nguide',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 10,
                                                child: Text(
                                                  'Are you \nfeeding your \npet property ?',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 13,
                                                    color: kPrimaryColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 0,
                                                top: 40,
                                                child: Image.asset(
                                                    'assets/images/chart.png'),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: fitToWidth(16, context)),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return BlocProvider.value(
                                            value: BlocProvider.of<FoodBloc>(
                                                context)
                                              ..add(GetRefillFoodDataEvent()),
                                            child: RefillTracker());
                                      }));
                                    },
                                    child: Container(
                                      height: MediaQuery.of(context)
                                              .devicePixelRatio *
                                          65,
                                      width: displayWidth(context) * 0.5 - 24,
                                      // decoration: BoxDecoration(
                                      //   color: Color(0xFFFFFFFF),
                                      //   borderRadius: BorderRadius.circular(16),
                                      // ),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8,
                                              left: 8,
                                              bottom: 10,
                                              top: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Refill Tracker',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              loadingData
                                                  ? LoadingIndicator()
                                                  : Text(
                                                      refillFood.daysLeft
                                                          .toString(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 50,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                              Text(
                                                'Days of food left',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  AnimatedContainer builsDot({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 15 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFC4C4C4),
        borderRadius: BorderRadius.circular(55),
      ),
    );
  }

  _buildGoToCarButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: fitToHeight(80, context),
        width: displayWidth(context) - 32,
        color: kCustomYellowColor,
        // decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '4 items awating you',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white,
                    // fontWeight: FontWeight.w500,
                  ),
                ),
                RaisedButton(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlocProvider(
                            create:(context)=>ShopBloc(),
                            child: ShoppingCart())));
                  },
                  child: Text(
                    'Go To Cart',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: kCustomYellowColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
