import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/profile/edit_profile_page.dart';
import 'package:pet_perfect_app/profile/update_profile_page.dart';
import 'package:pet_perfect_app/screens/components/default_button.dart';
import 'package:pet_perfect_app/screens/components/profile_bio_list.dart';
import 'package:pet_perfect_app/screens/components/side_bar.dart';
import 'package:pet_perfect_app/utils/utils.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';

import 'document_page.dart';

class FullProfilePage extends StatefulWidget {
  @override
  _FullProfilePageState createState() => _FullProfilePageState();
}

class _FullProfilePageState extends State<FullProfilePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // drawer: SideBar(),
        appBar: AppBar(
          title: Text(
            "Pet Perfect",
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          elevation: 0,
          backgroundColor: kPrimaryColor,
          // actions: [
          //   IconButton(
          //     icon: Image.asset(
          //       'assets/images/notification.png',
          //       color: Colors.white,
          //     ),
          //     onPressed: () {},
          //   ),
          // ],
        ),
        backgroundColor: kPrimaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                child: Container(
                  height: displayHeight(context) * 2.1,
                  width: double.infinity,
                  decoration: kBackgroundBoxDecoration(),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Edit profile",
                                style: kHeading22,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateProfilePage()));
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/profile.png',
                                      height: displayHeight(context) * 0.12,
                                      width: displayWidth(context) * 0.22,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DefaultButton(
                                press: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditProfilePage()));
                                },
                                text: 'Edit profile',
                                textColor: Colors.black,
                                bgColor: Colors.white,
                              ),
                              DefaultButton(
                                press: () {},
                                text: 'Share profile',
                                textColor: Colors.black,
                                bgColor: Colors.white,
                              ),
                              DefaultButton(
                                press: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DocumentPage()));
                                },
                                text: 'Documents',
                                textColor: Colors.black,
                                bgColor: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: displayHeight(context) * 0.08,
                            width: double.infinity,
                            decoration: kBox16Decoration(),
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: TabBar(
                                labelStyle:
                                    kHeading14.copyWith(color: kPrimaryColor),
                                labelColor: Colors.white,
                                unselectedLabelColor: kPrimaryColor,
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: kPrimaryColor),
                                tabs: [
                                  Tab(
                                    text: 'Generic',
                                    //                          style: GoogleFonts.poppins(
                                    // fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
                                  ),
                                  Tab(text: 'Personal'),
                                  Tab(text: 'Medical'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            height: displayHeight(context) * 0.9,
                            child: TabBarView(
                              children: [
                                Container(
                                  height: displayHeight(context) * 0.9,
                                  width: double.infinity,
                                  decoration: kBox12Decoration(),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ProfileBioList(
                                          text1: 'Pet name',
                                          text2: "Arya",
                                        ),
                                        ProfileBioList(
                                          text1: 'Breed',
                                          text2: "Cat",
                                        ),
                                        ProfileBioList(
                                          text1: 'Gender',
                                          text2: "Female",
                                        ),
                                        ProfileBioList(
                                          text1: 'Birthday',
                                          text2: "01/01/2010",
                                        ),
                                        ProfileBioList(
                                          text1: 'Registration Id',
                                          text2: "DL03289",
                                        ),
                                        ProfileBioList(
                                          text1: 'Appearance',
                                          text2:
                                              "Wild ferocious orangish sleepy cat",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: displayHeight(context) * 0.7,
                                  width: double.infinity,
                                  decoration: kBox12Decoration(),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ProfileBioList(
                                          text1: 'Likes',
                                          text2: "Fighting young puppies",
                                        ),
                                        ProfileBioList(
                                          text1: 'Dislikes',
                                          text2: "Competitor pets in home",
                                        ),
                                        ProfileBioList(
                                          text1: 'Body marks',
                                          text2: "Scratch mark on right eye",
                                        ),
                                        ProfileBioList(
                                          text1: 'Friendliness',
                                          text2: "Utra low",
                                        ),
                                        ProfileBioList(
                                          text1: 'Energy level',
                                          text2: "Very high to very low",
                                        ),
                                        ProfileBioList(
                                          text1: 'Favoured',
                                          text2: "Soft sound making ball",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: displayHeight(context) * 0.7,
                                  width: displayWidth(context) * 0.1,
                                  decoration: kBox12Decoration(),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ProfileBioList(
                                          text1: 'last measured weight',
                                          text2: " 4.2 kg",
                                        ),
                                        ProfileBioList(
                                          text1: 'last measured height',
                                          text2: "4.2''",
                                        ),
                                        ProfileBioList(
                                          text1: 'Medical history',
                                          text2: "M/A",
                                        ),
                                        ProfileBioList(
                                          text1: 'Hereditary',
                                          text2: "null",
                                        ),
                                        ProfileBioList(
                                          text1: 'Blood Group',
                                          text2: "0+ve",
                                        ),
                                        ProfileBioList(
                                          text1: 'Allergies',
                                          text2: "Can't tolerate pupples",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
