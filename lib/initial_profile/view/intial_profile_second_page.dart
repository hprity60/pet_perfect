import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/authentication/authentication.dart';
import 'package:pet_perfect_app/common/bloc/search_delegate_bloc.dart';
import 'package:pet_perfect_app/common/models/user_data.dart';
import 'package:pet_perfect_app/common/widgets/custom_search_delegate.dart';
import 'package:pet_perfect_app/common/widgets/custom_search_text_box.dart';
import 'package:pet_perfect_app/common/widgets/custom_text_box.dart';
import 'package:pet_perfect_app/common/widgets/primary_button.dart';
import 'package:pet_perfect_app/home/bloc/home_bloc.dart';
import 'package:pet_perfect_app/initial_profile/bloc/initial_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_perfect_app/profile/bloc/pet_profile_bloc.dart';
import 'package:pet_perfect_app/repositories/repositories.dart';
import 'package:pet_perfect_app/common/bottom_navigator.dart';
import 'package:pet_perfect_app/screens/Food/bloc/food_bloc.dart';
import 'package:pet_perfect_app/screens/Info/bloc/info_bloc.dart';
import 'package:pet_perfect_app/services/bloc/services_bloc.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/local_db_hive.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/utils/utils.dart';

class InitialProfileSecondPage extends StatefulWidget {
  @override
  _InitialProfileSecondPageState createState() =>
      _InitialProfileSecondPageState();

  final String petType;
  final String breed;
  final String gender;
  final DateTime birthday;
  final String parentName;

  const InitialProfileSecondPage(
      {Key key,
      this.petType,
      this.breed,
      this.birthday,
      this.gender,
      this.parentName})
      : super(key: key);
}

class _InitialProfileSecondPageState extends State<InitialProfileSecondPage> {
  final _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'intial_profile_second_page');

  @override
  void initState() {
    showLoading = false;
    super.initState();
  }

  final _petFirstNameController = TextEditingController();

  final _petLastNameController = TextEditingController();
  final _weightController = TextEditingController();
  List<String> bloodGroups;
  String selectedBloodGroup = "";

  bool showLoading;
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

  onNextPressed(BuildContext context) {
    if (_image == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please Add Your Pet\'s Picture'),
        backgroundColor: kredBackgroundColor,
      ));
    } else if (_petFirstNameController.text == '') {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please Add Your Pet\'s Name'),
        backgroundColor: kredBackgroundColor,
      ));
    } else {
      ///saving user data in user_data.dart
      UserData.user.parentName = widget.parentName;
      UserData.user.petType = widget.petType;
      UserData.user.breed = widget.breed;
      UserData.user.gender = widget.gender;
      UserData.user.petFirstName = _petFirstNameController.text;
      UserData.user.petLastName = _petLastNameController.text;
      UserData.user.petImage = _image;

      print("Printing Phone Number " + UserData.user.phoneNumber.toString());
      print("Printing Birthday " + widget.birthday.toString());
      BlocProvider.of<InitialProfileBloc>(context).add(
          InitialProfileRegisterPressedEvent(
              phoneNumber: UserData.user.phoneNumber,
              petType: widget.petType,
              breed: widget.breed,
              birthday: widget.birthday,
              gender: widget.gender,
              image: _image,
              petFirstName: _petFirstNameController.text,
              petLastName: _petLastNameController.text,
              weight: _weightController.text,
              bloodGroup: selectedBloodGroup));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // appBar: AppBar(
      //   backgroundColor: kSecondaryColor,
      //   elevation: 0,
      // ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: displayWidth(context) * 0.05,
            vertical: displayHeight(context) * 0.01),
        child: BlocConsumer<InitialProfileBloc, InitialProfileState>(
          listener: (context, state) {
            if (state is InitialProfileLoadingState) showLoading = true;
            if (state is InitialProfileAddingSuccessfulState) {
              print("Hellllloooooooo!!!!!!....Second Profile.dart");
              // UserData.user.savePetDetails(state.petId); TODO: Why was this here?
              LocalDb.setUserPetId(state.petId);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) =>
                                    BlocProvider.of<AuthenticationBloc>(
                                        context),
                              ),
                              BlocProvider(create: (context) => HomeBloc()),
                              BlocProvider(create: (context) => FoodBloc()),
                              BlocProvider(create: (context) => ServicesBloc()),
                              BlocProvider(create: (context) => InsightsBloc()),
                              BlocProvider(
                                  create: (context) => PetProfileBloc()),
                            ],
                            child: BottomNavigatorPage(),
                          )),
                  (Route<dynamic> route) => false);
            }
            if (state is InitialProfileAddingFailedState) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(state.error.toString()),
                backgroundColor: kredBackgroundColor,
              ));
              // BlocProvider.of<InitialProfileBloc>(context)
              //     .add(InitialProfileIntializeEvent());
              // Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Text(
                      "Pet Profile",
                      style: kHeading28.copyWith(color: kPrimaryColor),
                    ),
                    SizedBox(height: fitToHeight(24, context)),
                    Text(
                      "Set Your Pet's Profile Picture",
                      style: kHeading16.copyWith(color: kPrimaryColor),
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.01,
                    ),
                    FlatButton(
                      onPressed: () {
                        if (showLoading == false) selectImage(context);
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: kWhiteBackgroundColor,
                        child: _image == null
                            ? ((widget.petType == 'Cat')
                                ? Image.asset('assets/images/cat profile.png')
                                : Image.asset('assets/images/dog.png'))
                            : null,
                        backgroundImage:
                            _image == null ? null : FileImage(_image),
                      ),
                    ),
                    CustomTextBox(
                      // hintText: 'Pet Name',
                      labelText: 'First Name',
                      textEditingController: _petFirstNameController,
                      textInputType: TextInputType.name,
                      obscureText: false,
                    ),
                    CustomTextBox(
                      labelText: 'Last Name',
                      textEditingController: _petLastNameController,
                      textInputType: TextInputType.name,
                      obscureText: false,
                    ),
                    CustomTextBox(
                      // hintText: 'Weight (Kg)',
                      labelText: 'Weight (Kg)',
                      textEditingController: _weightController,
                      textInputType: TextInputType.number,
                      obscureText: false,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: displayHeight(context) * 0.01),
                      child: Container(
                        decoration: kBoxDecoration(),
                        child: CustomSearchTextBox(
                          borderColor: null,
                          textSize: 16,
                          textColor: selectedBloodGroup == ''
                              ? kPrimaryColor
                              : kPrimaryColor,
                          text: selectedBloodGroup == ''
                              ? 'Blood Group'
                              : selectedBloodGroup,
                          onPressed: () async {
                            final result = await showSearch(
                              context: context,
                              delegate: CustomSearchDelegate(
                                searchDelegateBloc: SearchDelegateBloc(),
                                dropdownOnly: true,
                                loadSuggestions:
                                    ApiRepository().getBloodGroupsList,
                                tag: widget.petType,
                                accessToken: UserData.user.accessToken,
                              ),
                            );
                            setState(() {
                              if (result != null && result != '')
                                selectedBloodGroup = result;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    showLoading
                        ? CircularProgressIndicator()
                        : Padding(
                            padding: const EdgeInsets.only(
                              left: 30,
                              right: 30,
                            ),
                            child: Builder(
                              builder: (context) => PrimaryButton(
                                title: 'Register',
                                onPressed: () => {onNextPressed(context)},
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
}
