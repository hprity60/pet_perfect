import 'package:flutter/material.dart';

Size displaySize(BuildContext context) {
  //debugPrint('Size = ' + MediaQuery.of(context).size.toString());
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  //debugPrint('Height = ' + displaySize(context).height.toString());
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  //debugPrint('Width = ' + displaySize(context).width.toString());
  return displaySize(context).width;
}

double dp(BuildContext context) {
  return MediaQuery.of(context).devicePixelRatio;
}

const double ASSUMED_SCREEN_HEIGHT = 829.0909090909091;
const double ASSUMED_SCREEN_WIDTH = 392.72727272727275;
double _fitContext(BuildContext context, assumedValue, currentValue, value) {
     return (value / assumedValue) * currentValue;
    }

fitToWidth(value, BuildContext context) => _fitContext(
    context, ASSUMED_SCREEN_WIDTH, MediaQuery.of(context).size.width, value);

fitToHeight(value, BuildContext context) => _fitContext(
    context,
    ASSUMED_SCREEN_HEIGHT,
    MediaQuery.of(context).size.height,
    value);
