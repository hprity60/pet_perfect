import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/screens/components/emergency_list.dart';
import 'package:pet_perfect_app/screens/components/side_bar.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';

class EmergencyPage extends StatefulWidget {
  final userName;
  final userImage;
  const EmergencyPage({
    this.userImage,
    this.userName,
  });
  @override
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Emergency",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: kPrimaryColor,
        
      ),
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                height: displayHeight(context) * 2,
                width: double.infinity,
                decoration: kBackgroundBoxDecoration(),
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 20, vertical: 20),
                    //   child: Row(
                    //     children: [
                    //       SizedBox(height: 10),
                    //       Text(
                    //         "Emergency",
                    //         style: kHeading22,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Fluttertoast.showToast(
                                    msg: "calling ambulance");
                              },
                              child: EmergencyList(
                                image: 'assets/images/emergency1.png',
                                text: "Call Ambulance",
                              ),
                            ),
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                Fluttertoast.showToast(
                                    msg: "calling pet helpline");
                              },
                              child: EmergencyList(
                                image: 'assets/images/emergency2.png',
                                text: "Call Pet Helpline",
                              ),
                            ),
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                Fluttertoast.showToast(
                                    msg: "calling stray help");
                              },
                              child: EmergencyList(
                                image: 'assets/images/emergency3.png',
                                text: "Call Stray Help",
                              ),
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
