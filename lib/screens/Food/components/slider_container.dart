import 'package:flutter/material.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';

class SliderContainer extends StatefulWidget {
  @override
  _SliderContainerState createState() => _SliderContainerState();
}

class _SliderContainerState extends State<SliderContainer> {
  static double _lowerValue = 1.0;
  static double _upperValue = 10.0;

  RangeValues values = RangeValues(_lowerValue, _upperValue);

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      min: _lowerValue,
      max: _upperValue,
      values: values,
      divisions: 5,
      activeColor: kPrimaryColor,
      inactiveColor: Colors.white,
      labels: RangeLabels(
          values.start.toInt().toString(), values.end.toInt().toString()),
      onChanged: (val) {
        setState(() {
          values = val;
        });
      },
    );
  }
}
