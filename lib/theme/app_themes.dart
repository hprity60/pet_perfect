import 'package:flutter/material.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';

class AppThemes {
  static final appThemeData = {
    AppTheme.lightTheme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kSecondaryColor,
        backgroundColor: kSecondaryColor,
        textTheme: TextTheme(
            bodyText1: TextStyle(
          color: primaryTextColor,
        ))),
    AppTheme.darkTheme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.red,
        backgroundColor: Colors.white,
        textTheme: TextTheme(
            bodyText1: TextStyle(
          color: Colors.white,
        ))),
  };
}

enum AppTheme {
  lightTheme,
  darkTheme,
}
