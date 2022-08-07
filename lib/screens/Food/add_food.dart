import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/common/bloc/search_delegate_bloc.dart';
import 'package:pet_perfect_app/common/widgets/custom_search_delegate.dart';
import 'package:pet_perfect_app/common/widgets/custom_search_text_box.dart';
import 'package:pet_perfect_app/repositories/api_repository.dart';
import 'package:pet_perfect_app/screens/Food/bloc/food_bloc.dart';
import 'package:pet_perfect_app/screens/Food/bloc/food_event.dart';
import 'package:pet_perfect_app/screens/Food/bloc/food_state.dart';
import 'package:pet_perfect_app/screens/Food/models/food.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';

class AddFood extends StatefulWidget {
  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  String selectedFood = '';
  int multiplier = 1;
  int quantity = 10;
  Food food;
  // FoodData foodData;
  // FoodData suggestedFoodData;
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return BlocListener<FoodBloc, FoodState>(
      listener: (context, state) {
        if (state is FoodDataLoadedState) {
          // foodData = state.foodData;
          // suggestedFoodData = state.suggestedFoodData;
        }
      },
      child: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Add Food",
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
                      height: displayHeight(context),
                      width: double.infinity,
                      decoration: kBackgroundBoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Container(
                                height: displayHeight(context) * 0.28,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // color: Color(0xFFF2F2F2),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 10),
                                    Text(
                                      'Quick Selection',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Wrap(
                                      children: [
                                        Chip(
                                          backgroundColor: kPrimaryColor,
                                          label: Text(
                                            'Eggs',
                                            style: GoogleFonts.poppins(
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Chip(
                                          backgroundColor: kPrimaryColor,
                                          label: Text(
                                            'Paneer',
                                            style: GoogleFonts.poppins(
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Chip(
                                          backgroundColor: kPrimaryColor,
                                          label: Text(
                                            'Chicken',
                                            style: GoogleFonts.poppins(
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Chip(
                                          backgroundColor: kPrimaryColor,
                                          label: Text(
                                            'Chicken',
                                            style: GoogleFonts.poppins(
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Chip(
                                          backgroundColor: kPrimaryColor,
                                          label: Text(
                                            'Eggs',
                                            style: GoogleFonts.poppins(
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Chip(
                                          backgroundColor: kPrimaryColor,
                                          label: Text(
                                            'Paneer',
                                            style: GoogleFonts.poppins(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),

                        /**Custom Drop down list */
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: displayWidth(context) * 0.01,
                              vertical: displayHeight(context) * 0.02),
                          child: Container(
                            height: displayHeight(context) * 0.068,
                            width: displayWidth(context) * 0.85,
                            decoration: kBoxDecoration(),
                            child: CustomSearchTextBox(
                              borderColor: null,
                              textSize: 16,
                              textColor: selectedFood == ''
                                  ? kPrimaryColor
                                  : kPrimaryColor,
                              text: selectedFood == '' ? 'Food' : selectedFood,
                              onPressed: () async {
                                final result = await showSearch(
                                  context: context,
                                  delegate: CustomSearchDelegate(
                                    searchDelegateBloc: SearchDelegateBloc(),
                                    loadSuggestions:
                                        ApiRepository().getAllFoodList,
                                    dropdownOnly: true,
                                    tag: selectedFood,
                                  ),
                                );
                                setState(() {
                                  if (result != null && result != '')
                                    selectedFood = result;
                                });
                                
                                print('selected food : $selectedFood');
                              },
                            ),
                          ),
                        ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Servings Size (gm)",
                                  style: GoogleFonts.poppins(
                                      color: kPrimaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Chip(
                                  backgroundColor: Colors.white,
                                  label: Text(
                                    quantity.toString()+" gm",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            // SliderContainer(),
                            Slider(
                              min: 1,
                              max: 1000,
                              // divisions: 10,
                              activeColor: kPrimaryColor,
                              inactiveColor: Colors.white,
                              value: quantity.toDouble(),
                              label: quantity.toInt().toString(),
                              onChanged: (val) {
                                // print(val.toInt());
                                setState(() {
                                  quantity = val.toInt();
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Servings (per day)",
                                  style: GoogleFonts.poppins(
                                      color: kPrimaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Chip(
                                  backgroundColor: Colors.white,
                                  label: Text(
                                    multiplier.toString(),
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            // SliderContainer(),
                            Slider(
                              min: 1,
                              max: 10,
                              divisions: 10,
                              activeColor: kPrimaryColor,
                              inactiveColor: Colors.white,
                              value: multiplier.toDouble(),
                              label: multiplier.toString(),
                              onChanged: (val) {
                                // print(val.toInt());
                                setState(() {
                                  multiplier = val.toInt();
                                });
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Container(
                                //   height: 36,
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(20),
                                //     border: Border.all(
                                //         color: kPrimaryColor, width: 2),
                                //   ),
                                //   child: FlatButton(
                                //     onPressed: () {
                                //       print(state.foodData.foods.length);
                                //     },
                                //     child: Text(
                                //       " Save and add another",
                                //       style: GoogleFonts.poppins(
                                //           fontSize: 14,
                                //           fontWeight: FontWeight.w400),
                                //     ),
                                //   ),
                                // ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    food = Food(
                                        name: selectedFood,
                                        multiplier: multiplier,
                                        quantity: quantity.toDouble(),
                                        unit: 'gm');

                                    state.foodData.foods.add(food);

                                    // print(state.foodData.foods.length);

                                    /** Adding event */
                                    BlocProvider.of<FoodBloc>(context).add(
                                        SaveButtonPressedEvent(
                                            foodData: state.foodData,
                                            suggestedFoodData:
                                                state.suggestedFoodData));
                                                
                                    Navigator.of(context).pop();
                                  },
                                  child: Chip(
                                    backgroundColor: kPrimaryColor,
                                    label: Text(
                                      " Save ",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ],
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

  _buildSearchFood(TextEditingController textEditingController) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Container(
        height: displayHeight(context) * 0.065,
        decoration: BoxDecoration(
          color: Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: 'Food Name',
            hintStyle: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: secondaryTextColor,
            ),
            prefixIcon: Image.asset(
              'assets/images/food (2).png',
              color: kPrimaryColor,
            ),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
                horizontal: 20, vertical: displayHeight(context) * 0.02),
          ),
          onEditingComplete: () {},
        ),
      ),
    );
  }
}
