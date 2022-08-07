import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/common/widgets/loading_indicator.dart';
import 'package:pet_perfect_app/common/widgets/zoomImage.dart';
import 'package:pet_perfect_app/profile/edit_profile_page.dart';
import 'package:pet_perfect_app/screens/components/default_button.dart';
import 'package:pet_perfect_app/screens/components/profile_bio_list.dart';
import 'package:pet_perfect_app/screens/components/side_bar.dart';
import 'package:pet_perfect_app/utils/utils.dart';
import 'package:pet_perfect_app/profile/update_profile_page.dart';
import 'package:pet_perfect_app/profile/document_page.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/profile/bloc/pet_profile_bloc.dart';
import 'package:pet_perfect_app/profile/models/pet_profile_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenericProfile extends StatefulWidget {
  @override
  _GenericProfileState createState() => _GenericProfileState();
}

class _GenericProfileState extends State<GenericProfile> {
  bool _loadingData = true;
  PetProfileModel petProfile;
  bool isEditable = false;
  String image;
  String thumbnail;
  TextEditingController name = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController breed = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController bloodGroup = TextEditingController();
  TextEditingController registrationId = TextEditingController();
  TextEditingController appearance = TextEditingController();
  TextEditingController likings = TextEditingController();
  TextEditingController dislikings = TextEditingController();
  TextEditingController bodyMarks = TextEditingController();
  TextEditingController friendliness = TextEditingController();
  TextEditingController enregyLevel = TextEditingController();
  TextEditingController favoured = TextEditingController();
  TextEditingController medicalHistory = TextEditingController();
  TextEditingController hereditary = TextEditingController();
  TextEditingController allergies = TextEditingController();
  TextEditingController training = TextEditingController();

  setData(state) {
    petProfile = state.petProfile;
    name.text = state.petProfile.name;
    type.text = state.petProfile.type;
    breed.text = state.petProfile.breed;
    birthday.text = state.petProfile.birthday;
    gender.text = state.petProfile.gender;
    weight.text = state.petProfile.weight;
    height.text = state.petProfile.height;
    bloodGroup.text = state.petProfile.bloodGroup;
    registrationId.text = state.petProfile.registrationId;
    appearance.text = state.petProfile.appearance;
    likings.text = state.petProfile.likings;
    dislikings.text = state.petProfile.dislikings;
    bodyMarks.text = state.petProfile.bodyMarks;
    friendliness.text = state.petProfile.friendliness;
    enregyLevel.text = state.petProfile.enregyLevel;
    favoured.text = state.petProfile.favoured;
    medicalHistory.text = state.petProfile.medicalHistory;
    hereditary.text = state.petProfile.hereditary;
    allergies.text = state.petProfile.allergies;
    training.text = state.petProfile.training;
    image = state.petProfile.image.url;
    thumbnail = state.petProfile.image.thumbnail;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: BlocListener<PetProfileBloc, PetProfileState>(
          listener: (context, state) {
            if (state is PetProfileLoadingState) {
              _loadingData = true;
            }
            if (state is PetProfileLoadedState) {
              _loadingData = false;
              setData(state);
            }
            if (state is PetProfileDataChangedState) {
              _loadingData = false;
              setData(state);
            }
            if (state is PetProfileLoadingFailedState) {
              Fluttertoast.showToast(msg: state.error);
            }
          },
          child: BlocBuilder<PetProfileBloc, PetProfileState>(
            builder: (context, state) {
              return Scaffold(
                drawer: SideBar(),
                appBar: AppBar(
                  title: Text(
                    "Pet Profile",
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
                          //  height: displayHeight(context) * 1.3 - 48,
                          // height: fitToHeight(
                          //     displayHeight(context) * 1.1 - 48, context),
                          width: displayWidth(context),
                          decoration: BoxDecoration(
                            color: kCustomWhiteColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        _loadingData
                                            ? Container()
                                            : GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (_) => ZoomImage(
                                                        imageUrl: image,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: CircleAvatar(
                                                  radius: 50,
                                                  backgroundColor:
                                                      kWhiteBackgroundColor,
                                                  backgroundImage:
                                                      NetworkImage(thumbnail),
                                                ),
                                              ),
                                        // Edit Share Document button

                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 24.0, right: 16),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 48,
                                                      child:
                                                          FloatingActionButton(
                                                        heroTag: 'Edit fab',
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: Icon(
                                                          Icons.edit,
                                                          color: customColor1,
                                                        ),
                                                        onPressed: () {
                                                          if (state
                                                                  is PetProfileLoadedState ||
                                                              state
                                                                  is PetProfileDataChangedState)
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (_) => BlocProvider.value(
                                                                        value: BlocProvider.of<PetProfileBloc>(
                                                                            context)
                                                                          ..add(PetProfileDataLoadingEvent(
                                                                              petProfile)),
                                                                        child:
                                                                            EditProfilePage())));
                                                        },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Text('  Edit'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 24.0, right: 16),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Container(
                                                      height: 48,
                                                      child:
                                                          FloatingActionButton(
                                                        heroTag: 'share fab',
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: Icon(
                                                          Icons.share,
                                                          color: customColor1,
                                                        ),
                                                        onPressed: () {},
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Text('Share'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 24.0, right: 16),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Container(
                                                      height: 48,
                                                      child:
                                                          FloatingActionButton(
                                                        heroTag: 'Document fab',
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: Icon(
                                                          Icons.add,
                                                          color: customColor1,
                                                        ),
                                                        onPressed: () {
                                                          
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      BlocProvider.value(
                                                          value: BlocProvider
                                                              .of<PetProfileBloc>(
                                                                  context),
                                                          child:
                                                              DocumentPage())));
                                                        },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Text('Document'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // SizedBox(height: 8),
                                  // Text(
                                  //   'Personality',
                                  //   style: GoogleFonts.poppins(
                                  //       fontSize: 16,
                                  //       fontWeight: FontWeight.w500),
                                  // ),

                                  // SizedBox(height: 8),
                                  // /**Chips */
                                  // Wrap(
                                  //   children: [
                                  //     Chip(
                                  //       backgroundColor: kPrimaryColor,
                                  //       label: Text(
                                  //         'Humble',
                                  //         style: GoogleFonts.poppins(
                                  //             color: Colors.white),
                                  //       ),
                                  //     ),
                                  //     SizedBox(width: 8),
                                  //     Chip(
                                  //       backgroundColor: kPrimaryColor,
                                  //       label: Text(
                                  //         'Brave',
                                  //         style: GoogleFonts.poppins(
                                  //             color: Colors.white),
                                  //       ),
                                  //     ),
                                  //     SizedBox(width: 8),
                                  //     Chip(
                                  //       backgroundColor: kPrimaryColor,
                                  //       label: Text(
                                  //         'Serious',
                                  //         style: GoogleFonts.poppins(
                                  //             color: Colors.white),
                                  //       ),
                                  //     ),
                                  //     SizedBox(width: 8),
                                  //     Chip(
                                  //       backgroundColor: kPrimaryColor,
                                  //       label: Text(
                                  //         'Respectful',
                                  //         style: GoogleFonts.poppins(
                                  //             color: Colors.white),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  SizedBox(height: 16),
                                  Container(
                                    height: 48,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: TabBar(
                                        labelStyle:
                                            GoogleFonts.poppins(fontSize: 14),
                                        labelColor: Colors.white,
                                        unselectedLabelColor: kPrimaryColor,
                                        indicator: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: kPrimaryColor),
                                        tabs: [
                                          Tab(text: 'Generic'),
                                          Tab(text: 'Personal'),
                                          Tab(text: 'Medical'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  _loadingData
                                      ? LoadingIndicator()
                                      :
                                      //  SingleChildScrollView(
                                      //     child:
                                      Container(
                                          height: fitToWidth(
                                              displayWidth(context) * 1.45,
                                              context),
                                          child: TabBarView(
                                            children: [
                                              Container(
                                                //  height: fitToHeight(200,context),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(13),
                                                  color: Colors.white,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ProfileBioList(
                                                        text1: 'Pet name',
                                                        // text2: "Arya",
                                                        textEditingController:
                                                            name,
                                                        isEditable: isEditable,
                                                      ),
                                                      SizedBox(height: 10),
                                                      ProfileBioList(
                                                        text1: 'Breed',
                                                        // text2: "Cat",
                                                        isEditable: isEditable,
                                                        textEditingController:
                                                            breed,
                                                      ),
                                                      SizedBox(height: 10),
                                                      ProfileBioList(
                                                        text1: 'Gender',
                                                        isEditable: isEditable,
                                                        textEditingController:
                                                            gender,
                                                      ),
                                                      SizedBox(height: 10),
                                                      ProfileBioList(
                                                        text1: 'Birthday',
                                                        isEditable: isEditable,
                                                        textEditingController:
                                                            birthday,
                                                      ),
                                                      SizedBox(height: 10),
                                                      ProfileBioList(
                                                        text1:
                                                            'Registration Id',
                                                        isEditable: isEditable,
                                                        textEditingController:
                                                            registrationId,
                                                      ),
                                                      SizedBox(height: 10),
                                                      ProfileBioList(
                                                        text1: 'Appearance',
                                                        isEditable: isEditable,
                                                        // "Wild ferocious orangish sleepy cat",
                                                        textEditingController:
                                                            appearance,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // height:
                                                //     displayHeight(context) *
                                                //         0.7,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(13),
                                                  color: Colors.white,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ProfileBioList(
                                                        text1: 'Likes',
                                                        isEditable: isEditable,
                                                        textEditingController:
                                                            likings,
                                                      ),
                                                      SizedBox(height: 10),
                                                      ProfileBioList(
                                                        text1: 'Dislikes',
                                                        isEditable: isEditable,
                                                        textEditingController:
                                                            dislikings,
                                                      ),
                                                      SizedBox(height: 10),
                                                      ProfileBioList(
                                                        text1: 'Body Marks',
                                                        isEditable: isEditable,
                                                        textEditingController:
                                                            bodyMarks,
                                                      ),
                                                      SizedBox(height: 10),
                                                      ProfileBioList(
                                                        text1: 'Friendliness',
                                                        isEditable: isEditable,
                                                        textEditingController:
                                                            friendliness,
                                                      ),
                                                      SizedBox(height: 10),
                                                      ProfileBioList(
                                                        text1: 'Training',
                                                        isEditable: isEditable,
                                                        textEditingController:
                                                            training,
                                                      ),
                                                      SizedBox(height: 10),
                                                      ProfileBioList(
                                                        text1: 'Energy Level',
                                                        isEditable: isEditable,
                                                        // "Wild ferocious orangish sleepy cat",
                                                        textEditingController:
                                                            enregyLevel,
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      ProfileBioList(
                                                        text1: 'Favoured Toys',
                                                        isEditable: isEditable,
                                                        textEditingController:
                                                            favoured,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: displayHeight(context) *
                                                    0.7,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(13),
                                                  color: Colors.white,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ProfileBioList(
                                                        text1:
                                                            'Last measured weight',
                                                        isEditable: isEditable,
                                                        textEditingController:
                                                            weight,
                                                      ),
                                                      SizedBox(height: 10),
                                                      ProfileBioList(
                                                        text1:
                                                            'Last measured height',
                                                        isEditable: isEditable,
                                                        textEditingController:
                                                            height,
                                                      ),
                                                      SizedBox(height: 10),
                                                      ProfileBioList(
                                                        text1:
                                                            'Medical history',
                                                        isEditable: isEditable,
                                                        textEditingController:
                                                            medicalHistory,
                                                      ),
                                                      SizedBox(height: 10),
                                                      ProfileBioList(
                                                        text1:
                                                            'Hereditary traits',
                                                        isEditable: isEditable,
                                                        textEditingController:
                                                            hereditary,
                                                      ),
                                                      SizedBox(height: 10),
                                                      ProfileBioList(
                                                        text1: 'Blood Group',
                                                        isEditable: isEditable,
                                                        textEditingController:
                                                            bloodGroup,
                                                      ),
                                                      SizedBox(height: 10),
                                                      ProfileBioList(
                                                        text1: 'Vaccine Chart',
                                                        isEditable: isEditable,
                                                        // textEditingController: ,
                                                      ),
                                                      SizedBox(height: 10),
                                                      ProfileBioList(
                                                        text1: 'Allergies',
                                                        isEditable: isEditable,
                                                        textEditingController:
                                                            allergies,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  // ),
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
            },
          ),
        ));
  }
}
