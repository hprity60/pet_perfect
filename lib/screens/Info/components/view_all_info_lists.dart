import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';

class ViewAllInfoLists extends StatelessWidget {
  const ViewAllInfoLists({
    Key key,
    this.infoText,
    this.infoImage,
    this.press,
  }) : super(key: key);
  final Function press;
  final String infoText, infoImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.all(displayWidth(context) * 0.02),
        child: Container(
          // width: 140,
          // height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                child: Image.network(
                  infoImage,
                  // width: 190,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9,vertical: 8),
                child: Container(
                  width: displayWidth(context)*0.28,
                  child: Text(
                    infoText,
                    // maxLines: 1,
                    // overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
