import 'package:flutter/material.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';

BoxDecoration kBackgroundBoxDecoration({double radius = 10, Color color}) {
  return BoxDecoration(
    color: kCustomWhiteColor,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
    ),
  );
}

BoxDecoration kBoxDecoration({double radius = 10, Color color}) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(radius),
  );
}

BoxDecoration kBox12Decoration({double radius = 12, Color color}) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(radius),
  );
}

BoxDecoration kBox16Decoration({double radius = 16, Color color}) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(radius),
  );
}

BoxDecoration kBox20Decoration({double radius = 20, Color color}) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(radius),
  );
}

BoxDecoration kBox5Decoration({double radius = 5, Color color}) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(radius),
  );
}

BoxDecoration kBox55Decoration({double radius = 55, Color color}) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(radius),
  );
}
