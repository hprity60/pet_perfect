import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/common/widgets/custom_text_box.dart';
import 'package:pet_perfect_app/common/widgets/loading_indicator.dart';
import 'package:pet_perfect_app/common/widgets/primary_button.dart';
import 'package:pet_perfect_app/repositories/repositories.dart';
import 'package:pet_perfect_app/screens/Food/bloc/food_bloc.dart';
import 'package:pet_perfect_app/screens/Food/bloc/food_state.dart';
import 'package:pet_perfect_app/screens/Food/models/food.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:date_time_picker/date_time_picker.dart';

class RefillTracker extends StatefulWidget {
  @override
  _RefillTrackerState createState() => _RefillTrackerState();
}

class _RefillTrackerState extends State<RefillTracker> {
  int quantity;
  int multiplier;
  final foodController = TextEditingController();
  final packSizeController = TextEditingController();
  String foodName;
  String _dob;
  bool loadingData = true;
  RefillFood refillFood;
  @override
  Widget build(BuildContext context) {
    return BlocListener<FoodBloc, FoodState>(
      listener: (context, state) {
        if (state is GetRefillDataLoadingState) {
          loadingData = true;
        }
        if (state is GetRefillDataLoadedState) {
          foodController.text = state.refillFood.foodName;
          packSizeController.text = state.refillFood.packSize.toString();
          quantity = state.refillFood.quantity;
          multiplier = state.refillFood.multiplier;
          foodName = state.refillFood.foodName;
          _dob = state.refillFood.date.toString();
          loadingData = false;
        }
      },
      child: BlocBuilder<FoodBloc, FoodState>(builder: (context, state) {
        print("state is $state");

        
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Refill Tracker",
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
                    height: displayHeight(context) ,
                    width: double.infinity,
                    decoration: kBackgroundBoxDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                      child: loadingData
                          ? LoadingIndicator()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               
                                CustomTextBox(
                                  // hintText: 'Food name',
                                  labelText: 'Food Name',
                                  textInputType: TextInputType.name,
                                  obscureText: false,
                                  textEditingController: foodController,
                                ),
                                // CustomTextBox(
                                //   hintText: 'Start Date',
                                //   labelText: 'Start Date',
                                //   textInputType: TextInputType.name,
                                //   obscureText: false,
                                // ),
                                _buildBirthdayField(),
                                CustomTextBox(
                                  // hintText: 'Pack Size',
                                  labelText: 'Pack Size (kg)',
                                  textInputType: TextInputType.name,
                                  obscureText: false,
                                  textEditingController: packSizeController,
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Feeding amount (gm)",
                                      style: GoogleFonts.poppins(
                                          color: kPrimaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Chip(
                                      backgroundColor: Colors.white,
                                      label: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          quantity.toString() + " gm",
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
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
                                    print(val.toInt());
                                    setState(() {
                                      quantity = val.toInt();
                                    });
                                  },
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      label: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          multiplier.toString(),
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
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
                                SizedBox(height: 48),
                                PrimaryButton(
                                  onPressed: () {
                                    ApiRepository()
                                        .setRefillTracker(refillFood);
                                  },
                                  title: 'Save',
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
      }),
    );
  }

  _buildBirthdayField() {
    return Padding(
      padding: EdgeInsets.symmetric( vertical: 10),
      child: Container(
        height: displayHeight(context) * 0.068,
        // width: displayWidth(context) * 0.67,
        width: double.infinity,
        decoration: kBoxDecoration(),
        child: DateTimePicker(
          decoration: InputDecoration(
            focusColor: primaryTextColor,
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            labelText: "Birthday",
            labelStyle: kHeading18.copyWith(color: kPrimaryColor,height: 1),
            contentPadding: EdgeInsets.only(left: 15.0, bottom: 8.0, top: 10.0),
          ),
          initialValue: _dob,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
          dateLabelText: 'Birthday',
          onChanged: (val) {
            setState(() {
              _dob = val;
            });
          },
          validator: (val) {
            return null;
          },
        ),
      ),
    );
  }
}
