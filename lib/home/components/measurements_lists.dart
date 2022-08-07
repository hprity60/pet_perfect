import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MeasurementsLists extends StatelessWidget {
  const MeasurementsLists({
    Key key,
    this.length,
    this.age,
    this.weight,
    this.date,
  }) : super(key: key);
  final double length;
  final int age;
  final double weight;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            age.toString(),
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            length.toString() + ' cm',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            weight.toString() + ' Kg',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
