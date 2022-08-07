import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/screens/components/side_bar.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: SideBar(),
      appBar: AppBar(
        title: Text(
          "Pet Perfect",
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
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 30,
              width: double.infinity,
              color: kPrimaryColor,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    right: 12,
                    top: -3,
                    child: Image.asset(
                      'assets/images/arrow.png',
                      height: 55,
                      width: 41,
                    ),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: displayHeight(context),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          SizedBox(height: 10),
                          Text(
                            "Notifications",
                            style: GoogleFonts.poppins(
                                fontSize: 22, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            NotificationLists(
                              image: 'assets/images/notify.png',
                              text: 'Get you a pet join today!',
                              time: '2 hours ago',
                              color: Color(0xFFFFFCC0),
                            ),
                            NotificationLists(
                              image: 'assets/images/notify.png',
                              text:
                                  'Buy a bowl for feeding you pet \nfood and proper care',
                              time: '7 hours ago',
                              color: kSecondaryColor,
                            ),
                            NotificationLists(
                              image: 'assets/images/notify.png',
                              text: 'Making you home safe for Arya',
                              time: '3 hours ago',
                              color: Color(0xFFFFFCC0),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationLists extends StatelessWidget {
  const NotificationLists({
    Key key,
    this.image,
    this.text,
    this.time,
    this.color,
  }) : super(key: key);
  final String image, text, time;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 63,
        color: color,
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                children: [
                  Image.asset(
                    image,
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: GoogleFonts.poppins(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        time,
                        style: GoogleFonts.poppins(
                            fontSize: 10, fontWeight: FontWeight.w400),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
