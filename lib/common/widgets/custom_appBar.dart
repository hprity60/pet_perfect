import 'package:flutter/material.dart';
import 'package:pet_perfect_app/home/view/notification_page.dart';

import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key key,
    this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.poppins(color: Colors.white),
      ),
      elevation: 0,
      backgroundColor: kPrimaryColor,
      actions: [
        IconButton(
          icon: Image.asset(
            'assets/images/notification.png',
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NotificationPage()));
          },
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(50.0);
}
