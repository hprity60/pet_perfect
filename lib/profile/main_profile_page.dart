import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/common/widgets/loading_indicator.dart';
import 'package:pet_perfect_app/profile/bloc/pet_profile_bloc.dart';
import 'package:pet_perfect_app/profile/models/pet_profile_model.dart';
import 'package:pet_perfect_app/screens/components/default_button.dart';
import 'package:pet_perfect_app/screens/components/side_bar.dart';
import 'package:pet_perfect_app/utils/utils.dart';
import 'package:pet_perfect_app/profile/update_profile_page.dart';
import 'package:pet_perfect_app/profile/generic_profile.dart';
import 'package:pet_perfect_app/profile/edit_profile_page.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/screens/components/profile_bio_list.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/profile/document_page.dart';

class MainProfilePage extends StatefulWidget {
  const MainProfilePage({Key key}) : super(key: key);
  @override
  _MainProfilePageState createState() => _MainProfilePageState();
}

class _MainProfilePageState extends State<MainProfilePage> {
  bool showLoading = true;
  PetProfileModel petProfileData;
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
        child: BlocConsumer<PetProfileBloc, PetProfileState>(
            listener: (context, state) {
          if (state is PetProfileInitialState ||
              state is PetProfileLoadingState) {
            showLoading = true;
          }
          if (state is PetProfileLoadedState) {
            showLoading = false;
            petProfileData = state.petProfile;
          }
          if (state is PetProfileLoadingFailedState) {
            Fluttertoast.showToast(msg: state.error);
          }
        }, builder: (context, state) {
          if (state is PetProfileLoadedState) {
            showLoading = false;
            petProfileData = state.petProfile;
          }
          return Column(
            children: [
              SingleChildScrollView(
                child: Container(
                  // height: displayHeight(context) * 0.84,
                  width: displayWidth(context),
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: showLoading
                        ? LoadingIndicator()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pet Profile',
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: displayHeight(context) * 0.03),
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
                                    child: Container(
                                      height: displayHeight(context) * 0.1,
                                      width: displayWidth(context) * 0.22,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              petProfileData.image.url),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: displayHeight(context) * 0.02),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    petProfileData.name,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: displayHeight(context) * 0.03),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  DefaultButton(
                                    press: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  BlocProvider.value(
                                                    value: BlocProvider.of<PetProfileBloc>(context),
                                                    child: EditProfilePage())));
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
                                              builder: (_) =>
                                                  BlocProvider.value(
                                                    value: BlocProvider.of<PetProfileBloc>(context),
                                                    child: DocumentPage())));
                                    },
                                    text: 'Documents',
                                    textColor: Colors.black,
                                    bgColor: Colors.white,
                                  ),
                                ],
                              ),
                              SizedBox(height: displayHeight(context) * 0.02),
                              Container(
                                height: displayHeight(context) * 0.5,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ProfileBioList(
                                        text1: 'Breed name',
                                        text2: petProfileData.breed,
                                      ),
                                      SizedBox(
                                          height:
                                              displayHeight(context) * 0.015),
                                      ProfileBioList(
                                        text1: 'Likes',
                                        text2: petProfileData.likings,
                                      ),
                                      SizedBox(
                                          height:
                                              displayHeight(context) * 0.015),
                                      ProfileBioList(
                                        text1: 'Appearance',
                                        text2: petProfileData.appearance,
                                      ),
                                      SizedBox(
                                          height:
                                              displayHeight(context) * 0.015),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      BlocProvider.value(
                                                        value: BlocProvider.of<PetProfileBloc>(context),
                                                        child: GenericProfile())));
                                        },
                                        child: Column(
                                          children: [
                                            Image.asset(
                                                'assets/images/downward.png'),
                                            SizedBox(
                                                height: displayHeight(context) *
                                                    0.01),
                                            Text(
                                              'View full profile',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
