import 'package:flutter/material.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';

class TopicsList extends StatelessWidget {
  const TopicsList({
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
        padding: EdgeInsets.all(displayWidth(context) * 0.01),
        child: Container(
          width: displayHeight(context) * 0.23,
          height: displayHeight(context) * 0.2,
          decoration: kBox12Decoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8)),
                child: Image.network(
                  infoImage,
                  width: displayWidth(context) ,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Container(
                  width: displayWidth(context) * 0.28,
                  child: Text(
                    infoText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: kHeading14,
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
