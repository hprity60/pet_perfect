import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/profile/edit_profile_page.dart';
import 'package:pet_perfect_app/screens/components/category_button.dart';
import 'package:pet_perfect_app/screens/components/default_button.dart';
import 'package:pet_perfect_app/screens/components/profile_bio_list.dart';
import 'package:pet_perfect_app/screens/components/side_bar.dart';
import 'package:pet_perfect_app/utils/utils.dart';
import 'package:pet_perfect_app/profile/update_profile_page.dart';
import 'package:pet_perfect_app/profile/generic_profile.dart';
import 'package:pet_perfect_app/profile/personal_profile.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/profile/document_page.dart';

class MedicalProfile extends StatefulWidget {
  @override
  _MedicalProfileState createState() => _MedicalProfileState();
}

class _MedicalProfileState extends State<MedicalProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
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
            SingleChildScrollView(
              child: Container(
                height: displayHeight(context) * 0.9,
                width: displayWidth(context),
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                  ),
                ),
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
                              style: GoogleFonts.poppins(fontSize: 20),
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
                                    height: 75,
                                    width: 75,
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
                                        builder: (context) => DocumentPage()));
                              },
                              text: 'Documents',
                              textColor: Colors.black,
                              bgColor: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 48,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 5),
                              CategoryButton(
                                press: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              GenericProfile()));
                                },
                                text: 'Generic',
                                textColor: kPrimaryColor,
                                bgColor: Colors.white,
                              ),
                              CategoryButton(
                                press: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PersonalProfile()));
                                },
                                text: 'Personal',
                                textColor: kPrimaryColor,
                                bgColor: Colors.white,
                              ),
                              CategoryButton(
                                press: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MedicalProfile()));
                                },
                                text: 'Medical',
                                textColor: Colors.white,
                                bgColor: kPrimaryColor,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: displayHeight(context) * 0.7,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProfileBioList(
                                  text1: 'last measured weight',
                                  text2: " 4.2 kg",
                                ),
                                SizedBox(height: 10),
                                ProfileBioList(
                                  text1: 'last measured height',
                                  text2: "4.2''",
                                ),
                                SizedBox(height: 10),
                                ProfileBioList(
                                  text1: 'Medical history',
                                  text2: "M/A",
                                ),
                                SizedBox(height: 10),
                                ProfileBioList(
                                  text1: 'Hereditary',
                                  text2: "null",
                                ),
                                SizedBox(height: 10),
                                ProfileBioList(
                                  text1: 'Blood Group',
                                  text2: "0+ve",
                                ),
                                SizedBox(height: 10),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
