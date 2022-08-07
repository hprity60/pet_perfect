import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key key,
    this.text1,
    this.text2, //date
    this.text3,
    this.color1,
    this.color2,
    this.bgColor,
  }) : super(key: key);
  final text1, text3;
  final DateTime text2;
  final Color bgColor, color1, color2;

  @override
  Widget build(BuildContext context) {
    Color color3;
    if (text3 == 'PENDING') {
      color3 = Colors.red;
    } else if (text3 == 'COMPLETED') {
      color3 = Colors.green;
    } else if (text3 == 'UPCOMING') {
      color3 = Colors.yellow;
    }
    return Container(
      // height: 44,
      width: double.infinity,
      child: Column(
        children: [
          Divider(),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  text1.toString(),
                  softWrap: true,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: color1,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                // text2,
                DateFormat.yMd().format(text2),
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: color2,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      text3,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: color3,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
