import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/common/widgets/loading_indicator.dart';
import 'package:pet_perfect_app/screens/Food/bloc/food_bloc.dart';
import 'package:pet_perfect_app/screens/Food/bloc/food_event.dart';
import 'package:pet_perfect_app/screens/Food/bloc/food_state.dart';
import 'package:pet_perfect_app/screens/Food/models/food.dart';
import 'package:pet_perfect_app/screens/components/default_button.dart';
import 'package:pet_perfect_app/screens/Food/add_food.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';

class NutritionsGuide extends StatefulWidget {
  @override
  _NutritionsGuideState createState() => _NutritionsGuideState();
}

class _NutritionsGuideState extends State<NutritionsGuide> {
  // FoodData foodData;
  FoodData suggestedFoodData;
  bool foodDataLoading = true;

  @override
  Widget build(BuildContext context) {
    final foodBloc = BlocProvider.of<FoodBloc>(context);
    return BlocListener<FoodBloc, FoodState>(
      listener: (context, state) {
        if (state is FoodDataLoadingState) {
          foodDataLoading = true;
        }
        if (state is FoodDataLoadedState) {
          // foodData = state.foodData;
          suggestedFoodData = state.suggestedFoodData;
          foodDataLoading = false;
        }

        if (state is FoodDataAddedState) {
          // foodData = state.foodData;
          suggestedFoodData = state.suggestedFoodData;
          foodDataLoading = false;
        }

        if (state is FoodDataDeletedState) {
          foodDataLoading = false;
        }
      },
      child: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          if (!foodDataLoading) {
            print("building page");
            print("food length is");
            print(state.foodData.foods.length);

            // print(state.foodData.foods[5].name);
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Nutrition Guide",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              elevation: 0,
              backgroundColor: kPrimaryColor,
            ),
            backgroundColor: kPrimaryColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      height: displayHeight(context) * 2,
                      width: double.infinity,
                      decoration: kBackgroundBoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(vertical: 16),
                            //   child: Text(
                            //     "Suggesting for Arya, 2 years, 3 kg",
                            //     style: kHeading11,
                            //   ),
                            // ),

                            Row(
                              children: [
                                Text(
                                  "Current Diet",
                                  style: kHeading22,
                                ),
                                Text(
                                  "(per day)",
                                  style: kHeading18.copyWith(
                                      color: secondaryTextColor),
                                  //color: Colors.black45,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.error,
                                    color: kPrimaryColor,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                            Container(
                              // height: 169,
                              width: double.infinity,
                              decoration: kBoxDecoration(),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 10, top: 10, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    foodDataLoading
                                        ? LoadingIndicator()
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                state.foodData.foods.length,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  // DietLists(),

                                                  _buildDietList(
                                                    foodData: state.foodData,
                                                    index: index,
                                                    foodName: state.foodData
                                                        .foods[index].name,
                                                    foodQuantity:
                                                        // '3 x 100g'
                                                        '${state.foodData.foods[index].multiplier} x ${state.foodData.foods[index].quantity}${state.foodData.foods[index].unit}',
                                                  ),
                                                  Divider(
                                                      color: Colors.black12),
                                                ],
                                              );
                                            },
                                          ),
                                    Container(
                                      width: (displayWidth(context)-32)/3,
                                      child: DefaultButton(
                                        bgColor: kPrimaryColor,
                                        text: 'Add Food',
                                        textColor: kWhiteBackgroundColor,
                                        press: () {
                                          BlocProvider.of<FoodBloc>(context)
                                              .add(AddButtonPressedEvent(
                                            foodData: state.foodData,
                                            suggestedFoodData:
                                                state.suggestedFoodData,
                                          ));

                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (_) {
                                            return BlocProvider.value(
                                                value:
                                                    BlocProvider.of<FoodBloc>(
                                                        context),
                                                child: AddFood());
                                          }));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              // height: 162,
                              width: double.infinity,

                              decoration: kBoxDecoration(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Suggested Food',
                                          style: kHeading18,
                                        ),
                                      ],
                                    ),
                                    foodDataLoading
                                        ? LoadingIndicator()
                                        : Wrap(
                                            children: [
                                              ListView.builder(
                                                shrinkWrap: true,
                                                //  scrollDirection: Axis.horizontal,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: suggestedFoodData
                                                    .foods.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Chip(
                                                    label: Text(
                                                      suggestedFoodData
                                                          .foods[index].name,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                    backgroundColor:
                                                        kPrimaryColor,
                                                  );
                                                },
                                              ),

                                              
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Food Chart",
                                  style: kHeading22,
                                ),
                                Text(
                                  "(per day)",
                                  style: kHeading18.copyWith(
                                      color: secondaryTextColor),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.error,
                                    color: kPrimaryColor,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: false,
                                  onChanged: (value) {},
                                ),
                                Text(
                                  "Show only veg suggestions",
                                  style: kHeading14.copyWith(
                                      color: secondaryTextColor),
                                ),
                              ],
                            ),
                            SingleChildScrollView(
                              child: Container(
                                height: displayHeight(context) * 0.45,
                                width: double.infinity,
                                decoration: kBoxDecoration(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 28,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Nutrient',
                                              style: kHeading14,
                                            ),
                                            Text(
                                              'Req',
                                              style: kHeading14,
                                            ),
                                            Text(
                                              'Curr',
                                              style: kHeading14,
                                            ),
                                            Text(
                                              'Suggested Food',
                                              style: kHeading14,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _buildDietList(
      {String foodName, String foodQuantity, int index, FoodData foodData}) {
    return Container(
      height: 28,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              foodName,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Text(
            foodQuantity,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: kPrimaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      foodData.foods.removeAt(index);
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
