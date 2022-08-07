import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/common/widgets/loading_indicator.dart';
import 'package:pet_perfect_app/screens/components/default_button.dart';
import 'package:pet_perfect_app/screens/components/edit_text_field.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/local_db_hive.dart';
import 'package:pet_perfect_app/utils/utils.dart';
import 'package:pet_perfect_app/common/bloc/search_delegate_bloc.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/profile/bloc/pet_profile_bloc.dart';
import 'package:pet_perfect_app/profile/models/pet_profile_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_perfect_app/common/models/user_data.dart';

import 'package:pet_perfect_app/common/widgets/custom_search_delegate.dart';
import 'package:pet_perfect_app/repositories/repositories.dart';

import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool _loadingData = true;
  PetProfileModel _petProfile;
  String petImage;
  bool isEditable = true;
  String petType;
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

  String selectedBreed;
  String selectedFriendliness;
  String selectedTraining;
  String selectedBloodGroup;
  String _dob;
  final picker = ImagePicker();
  File _image;
  Future getImage(ImageSource source, BuildContext ctx) async {
    Navigator.pop(ctx);
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Fluttertoast.showToast(msg: "No Image selected!");
      }
    });
  }

  selectImage(BuildContext ctx) {
    return showDialog(
        context: ctx,
        builder: (ctx) {
          return SimpleDialog(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            title: Text('Create Post'),
            children: <Widget>[
              SimpleDialogOption(
                child: Text('Choose from Camera'),
                onPressed: () => getImage(ImageSource.camera, ctx),
              ),
              SimpleDialogOption(
                child: Text('Choose from Gallery'),
                onPressed: () => getImage(ImageSource.gallery, ctx),
              ),
              SimpleDialogOption(
                child: Text('Cancel'),
                onPressed: Navigator.of(ctx).pop,
              ),
            ],
          );
        });
  }

  // editDataInState(PetProfileLoadedState state) {
  //   _petProfile.name = name.text;
  //   _petProfile.breed = breed.text;
  // }

  attachDataToController(state) {
    petImage = state.petProfile.image.url;
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
  }

  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<PetProfileBloc>(context);
    return DefaultTabController(
      length: 3,
      child: BlocListener<PetProfileBloc, PetProfileState>(
        listener: (context, state) {
          if (state is PetProfileLoadingState) {
            _loadingData = true;
          }

          if (state is PetProfileLoadedState) {
            _loadingData = false;
            _petProfile = state.petProfile;
            attachDataToController(state);
          }
          if (state is PetProfileEditState) {
            _loadingData = false;
            _petProfile = state.petProfile;
            attachDataToController(state);
          }

          if (state is PetProfileDataChangedState) {
            _loadingData = false;
            _petProfile = state.petProfile;
            attachDataToController(state);
          }
        },
        child: BlocBuilder<PetProfileBloc, PetProfileState>(
          builder: (context, state) {
            return Scaffold(
              // drawer: SideBar(),
              appBar: AppBar(
                title: Text(
                  "Edit Profile",
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
                        // height: displayHeight(context),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _image == null
                                        ? Stack(
                                            alignment: Alignment(1.42, 0.8),
                                            children: <Widget>[
                                                _loadingData
                                                    ? Container()
                                                    : CircleAvatar(
                                                        backgroundColor:
                                                            Color(0xfff8faf8),
                                                        radius: 60,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                petImage),
                                                      ),
                                                Container(
                                                    height: 28,
                                                    child: FloatingActionButton(
                                                        elevation: 4,
                                                        backgroundColor:
                                                            Color(0xffE25E60),
                                                        onPressed: () =>
                                                            selectImage(
                                                                context),
                                                        child: Icon(
                                                          Icons.add,
                                                        )))
                                              ])
                                        : Stack(
                                            alignment: Alignment(1.42, 0.8),
                                            children: [
                                              CircleAvatar(
                                                  backgroundColor:
                                                      Color(0xfff8faf8),
                                                  radius: 60,
                                                  child: Image.file(
                                                    _image,
                                                  )),
                                            ],
                                          ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Column(
                                  children: [
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
                                  ],
                                ),
                                SizedBox(height: 16),
                                _loadingData
                                    ? LoadingIndicator()
                                    : Container(
                                        height: fitToWidth(
                                            displayWidth(context) * 1.75,
                                            context),
                                        child: TabBarView(
                                          children: [
                                            Container(
                                              // height: displayHeight(context),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                color: Colors.white,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                child: Column(
                                                  children: [
                                                    EditTextField(
                                                      labelText: 'Pet name',
                                                      // text2: "Arya",
                                                      textEditingController:
                                                          name,
                                                      isEditable: isEditable,
                                                      onChanged: (val) {
                                                        _petProfile.name = val;
                                                      },
                                                    ),
                                                    Container(
                                                      height: 10,
                                                      color: Colors.white,
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        final result =
                                                            await showSearch(
                                                          context: context,
                                                          delegate: CustomSearchDelegate(
                                                              searchDelegateBloc:
                                                                  SearchDelegateBloc(),
                                                              loadSuggestions:
                                                                  ApiRepository()
                                                                      .getBreedList,
                                                              dropdownOnly:
                                                                  false,
                                                              tag: petType,
                                                              accessToken: LocalDb
                                                                  .userAccessToken),
                                                        );
                                                        setState(() {
                                                          if (result != null &&
                                                              result != '')
                                                            selectedBreed =
                                                                result;
                                                          breed.text = result;
                                                          _petProfile.breed =
                                                              result;
                                                        });
                                                      },
                                                      child: EditTextField(
                                                        labelText: 'Breed',
                                                        isEditable: false,
                                                        textEditingController:
                                                            breed,
                                                        suffixIcon: Icon(Icons
                                                            .arrow_drop_down),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    EditTextField(
                                                      labelText: 'Gender',
                                                      isEditable: isEditable,
                                                      textEditingController:
                                                          gender,
                                                      onChanged: (val) {
                                                        _petProfile.gender =
                                                            val;
                                                      },
                                                    ),
                                                    SizedBox(height: 10),
                                                    _buildBirthdayField(),
                                                    SizedBox(height: 10),
                                                    EditTextField(
                                                      labelText:
                                                          'Registration Id',
                                                      isEditable: isEditable,
                                                      textEditingController:
                                                          registrationId,
                                                      onChanged: (val) {
                                                        _petProfile
                                                                .registrationId =
                                                            val;
                                                      },
                                                    ),
                                                    SizedBox(height: 10),
                                                    EditTextField(
                                                      labelText: 'Appearance',
                                                      isEditable: isEditable,
                                                      // "Wild ferocious orangish sleepy cat",
                                                      textEditingController:
                                                          appearance,
                                                      onChanged: (val) {
                                                        _petProfile.appearance =
                                                            val;
                                                      },
                                                    ),
                                                    SizedBox(height: 25),
                                                    SizedBox(
                                                      height: 36,
                                                      width: double.infinity,
                                                      child: DefaultButton(
                                                        text: "Save changes",
                                                        textColor: Colors.white,
                                                        bgColor: kPrimaryColor,
                                                        press: () {
                                                          profileBloc.add(
                                                              PetProfileDataChangedEvent(
                                                                  _petProfile));
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                color: Colors.white,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                child: Column(
                                                  children: [
                                                    EditTextField(
                                                      labelText: 'Likes',
                                                      // text2: "Arya",
                                                      textEditingController:
                                                          likings,
                                                      isEditable: isEditable,
                                                      onChanged: (val) {
                                                        _petProfile.likings =
                                                            val;
                                                      },
                                                    ),
                                                    SizedBox(height: 10),
                                                    EditTextField(
                                                      labelText: 'Dislikes',
                                                      // text2: "Cat",
                                                      isEditable: isEditable,
                                                      textEditingController:
                                                          dislikings,
                                                      onChanged: (val) {
                                                        _petProfile.dislikings =
                                                            val;
                                                      },
                                                    ),
                                                    SizedBox(height: 10),
                                                    EditTextField(
                                                      labelText: 'Body Marks',
                                                      isEditable: isEditable,
                                                      textEditingController:
                                                          bodyMarks,
                                                      onChanged: (val) {
                                                        _petProfile.bodyMarks =
                                                            val;
                                                      },
                                                    ),
                                                    SizedBox(height: 10),
                                                    InkWell(
                                                        onTap: () async {
                                                          final result =
                                                              await showSearch(
                                                            context: context,
                                                            delegate:
                                                                CustomSearchDelegate(
                                                              searchDelegateBloc:
                                                                  SearchDelegateBloc(),
                                                              loadSuggestions:
                                                                  ApiRepository()
                                                                      .getBreedList,
                                                              dropdownOnly:
                                                                  false,
                                                              tag: petType,
                                                            ),
                                                          );
                                                          setState(() {
                                                            if (result !=
                                                                    null &&
                                                                result != '')
                                                              selectedFriendliness =
                                                                  result;
                                                            friendliness.text =
                                                                result;
                                                          });
                                                        },
                                                        child: EditTextField(
                                                          labelText:
                                                              'Friendliness',
                                                          isEditable: false,
                                                          textEditingController:
                                                              friendliness,
                                                          suffixIcon: Icon(Icons
                                                              .arrow_drop_down),
                                                          onChanged: (val) {
                                                            _petProfile
                                                                    .friendliness =
                                                                val;
                                                          },
                                                        )),
                                                    SizedBox(height: 10),
                                                    InkWell(
                                                        onTap: () async {
                                                          final result =
                                                              await showSearch(
                                                            context: context,
                                                            delegate:
                                                                CustomSearchDelegate(
                                                              searchDelegateBloc:
                                                                  SearchDelegateBloc(),
                                                              loadSuggestions:
                                                                  ApiRepository()
                                                                      .getBreedList,
                                                              dropdownOnly:
                                                                  false,
                                                              tag: petType,
                                                            ),
                                                          );
                                                          setState(() {
                                                            if (result !=
                                                                    null &&
                                                                result != '')
                                                              selectedTraining =
                                                                  result;
                                                            training.text =
                                                                result;
                                                            _petProfile
                                                                    .training =
                                                                result;
                                                          });
                                                        },
                                                        child: EditTextField(
                                                          labelText: 'Training',
                                                          isEditable: false,
                                                          textEditingController:
                                                              training,
                                                          suffixIcon: Icon(Icons
                                                              .arrow_drop_down),
                                                          onChanged: (val) {
                                                            // _petProfile
                                                            //     .training = val;
                                                          },
                                                        )),
                                                    SizedBox(height: 10),
                                                    EditTextField(
                                                      labelText: 'Energy Level',
                                                      isEditable: isEditable,
                                                      // "Wild ferocious orangish sleepy cat",
                                                      textEditingController:
                                                          enregyLevel,
                                                    ),
                                                    SizedBox(height: 10),
                                                    EditTextField(
                                                      labelText:
                                                          'Favoured Toys',
                                                      isEditable: isEditable,
                                                      // "Wild ferocious orangish sleepy cat",
                                                      textEditingController:
                                                          favoured,
                                                    ),
                                                    SizedBox(height: 25),
                                                    SizedBox(
                                                      height: 36,
                                                      width: double.infinity,
                                                      child: DefaultButton(
                                                        text: "Save changes",
                                                        textColor: Colors.white,
                                                        bgColor: kPrimaryColor,
                                                        press: () {
                                                          profileBloc.add(
                                                              PetProfileDataChangedEvent(
                                                                  _petProfile));
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: displayHeight(context),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                color: Colors.white,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                child: Column(
                                                  children: [
                                                    EditTextField(
                                                      labelText:
                                                          'last measured weight',
                                                      hintText: '4.2 kg',
                                                      isEditable: isEditable,
                                                      textEditingController:
                                                          weight,
                                                    ),
                                                    SizedBox(height: 10),
                                                    EditTextField(
                                                      labelText:
                                                          'last measured height',
                                                      hintText: "4.2''",
                                                      isEditable: isEditable,
                                                      textEditingController:
                                                          height,
                                                    ),
                                                    SizedBox(height: 10),
                                                    EditTextField(
                                                      labelText:
                                                          'Medical history',
                                                      hintText: 'N/A',
                                                      isEditable: isEditable,
                                                      textEditingController:
                                                          medicalHistory,
                                                    ),
                                                    SizedBox(height: 10),
                                                    EditTextField(
                                                      labelText: 'Hereditary',
                                                      hintText: 'null',
                                                      isEditable: isEditable,
                                                      textEditingController:
                                                          hereditary,
                                                    ),
                                                    SizedBox(height: 10),
                                                    InkWell(
                                                        onTap: () async {
                                                          final result =
                                                              await showSearch(
                                                            context: context,
                                                            delegate:
                                                                CustomSearchDelegate(
                                                              searchDelegateBloc:
                                                                  SearchDelegateBloc(),
                                                              loadSuggestions:
                                                                  ApiRepository()
                                                                      .getBloodGroupsList,
                                                              dropdownOnly:
                                                                  true,
                                                              tag: petType,
                                                              accessToken: LocalDb
                                                                  .userAccessToken,
                                                            ),
                                                          );
                                                          setState(() {
                                                            if (result !=
                                                                    null &&
                                                                result != '')
                                                              selectedBloodGroup =
                                                                  result;
                                                            bloodGroup.text =
                                                                result;
                                                          });
                                                        },
                                                        child: EditTextField(
                                                          labelText:
                                                              'Blood Group',
                                                          textEditingController:
                                                              bloodGroup,
                                                          isEditable: false,
                                                          suffixIcon: Icon(Icons
                                                              .arrow_drop_down),
                                                        )),
                                                    SizedBox(height: 10),
                                                    EditTextField(
                                                      labelText: 'Allergies',
                                                      hintText:
                                                          "Can't tolerate pupples",
                                                      isEditable: isEditable,
                                                      textEditingController:
                                                          allergies,
                                                    ),
                                                    SizedBox(height: 25),
                                                    SizedBox(
                                                      height: 36,
                                                      width: double.infinity,
                                                      child: DefaultButton(
                                                        text: "Save changes",
                                                        textColor: Colors.white,
                                                        bgColor: kPrimaryColor,
                                                        press: () {
                                                          profileBloc.add(
                                                              PetProfileDataChangedEvent(
                                                                  _petProfile));
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
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
      ),
    );
  }

  _saveDetails() {
    final petProfile = PetProfileModel(
      allergies: allergies.text,
      appearance: appearance.text,
      birthday: birthday.text,
      bloodGroup: bloodGroup.text,
      bodyMarks: bodyMarks.text,
      breed: breed.text,
      dislikings: dislikings.text,
      enregyLevel: enregyLevel.text,
      favoured: favoured.text,
      friendliness: friendliness.text,
      gender: gender.text,
      hereditary: hereditary.text,
      likings: likings.text,
      medicalHistory: medicalHistory.text,
      name: name.text,
      registrationId: registrationId.text,
      training: training.text,
      type: type.text,
      weight: weight.text,
    );
  }

  _buildBirthdayField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        children: [
          Container(
            // height: displayHeight(context) * 0.077,
            // width: displayWidth(context) * 0.9,
            decoration: kBoxDecoration(color: kTextFieldColor),
            child: DateTimePicker(
              decoration: InputDecoration(
                border: InputBorder.none,
                focusColor: primaryTextColor,
                suffixIcon: Icon(
                  Icons.date_range_rounded,
                  color: primaryTextColor,
                ),
                labelText: "Birthday",
                labelStyle: kHeading16.copyWith(height: -1),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              initialValue: _dob,
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
              dateLabelText: 'vsf',
              onChanged: (val) {
                setState(() {
                  _dob = val;
                });
              },
              validator: (val) {
                return null;
              },
            ),
          ),
          Divider(
            color: Colors.black12,
          )
        ],
      ),
    );
  }
}
