import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pet_perfect_app/common/models/user_data.dart';
import 'package:pet_perfect_app/common/bloc/search_delegate_bloc.dart';

import 'package:pet_perfect_app/common/widgets/custom_search_delegate.dart';
import 'package:pet_perfect_app/common/widgets/custom_search_text_box.dart';

import 'package:pet_perfect_app/common/widgets/primary_button.dart';
import 'package:pet_perfect_app/initial_profile/bloc/initial_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pet_perfect_app/initial_profile/view/view.dart';
import 'package:pet_perfect_app/repositories/repositories.dart';

import 'package:group_radio_button/group_radio_button.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/local_db_hive.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import '../../utils/color_helpers.dart';

class InitialProfileFirstPage extends StatefulWidget {
  @override
  _InitialProfileFirstPageState createState() =>
      _InitialProfileFirstPageState();
}

class _InitialProfileFirstPageState extends State<InitialProfileFirstPage> {
  InitialProfileBloc _initialProfileBloc;
  String parentName;
  DateTime _dob;
  String selectedBreed = '';
  String petType = '';
  String selectedGender = "";
  List<String> _status = ["Male", "Female"];
  final _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'intial_profile_first_page');

  final _breedController = TextEditingController();
  final _genderController = TextEditingController();

  @override
  void initState() {
    _initialProfileBloc = BlocProvider.of<InitialProfileBloc>(context);
    super.initState();
  }

  @override
  void deactivate() {
    _initialProfileBloc.close();
    super.deactivate();
  }

  onNextPressed(BuildContext context) {
    print("helllllo" + selectedBreed);
    if (petType == null || petType == '') {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please Select Your Pet Type!'),
        backgroundColor: kredBackgroundColor,
      ));
    } else if (selectedBreed == null || selectedBreed == '') {
      print(selectedBreed);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please Enter Your Pet\'s Breed!'),
        backgroundColor: kredBackgroundColor,
      ));
    } else if (_dob == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please Enter Your Pet\'s Birthday!'),
        backgroundColor: kredBackgroundColor,
      ));
    } else if (selectedGender == null || selectedGender == '') {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please Enter Your Pet\'s Gender!'),
        backgroundColor: kredBackgroundColor,
      ));
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => _initialProfileBloc,
            child: InitialProfileSecondPage(
              petType: petType,
              birthday: _dob,
              gender: selectedGender,
              breed: selectedBreed,
            ),
          ),
        ),
      );
    }
  }

// 3e0b545a-5c0f-4d58-9440-b8cc8a67158d
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      key: _scaffoldKey,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: displayWidth(context) * 0.05,
            vertical: displayHeight(context) * 0.05),
        child: BlocConsumer<InitialProfileBloc, InitialProfileState>(
          listener: (context, state) {
            if (state is InitialProfileIntialState) {
              _dob = null;
              _breedController.clear();
              _genderController.clear();
              petType = null;
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Greetings ${UserData.user.parentFirstName} !",
                      style: kHeading30.copyWith(color: kPrimaryColor),
                    ),
                    Text(
                      "Let's create Your Pet Profile",
                      style: kHeading16.copyWith(color: kPrimaryColor),
                    ),
                    SizedBox(height: displayHeight(context) * 0.04),
                    Text(
                      "What type of Pet do you have?",
                      style: kHeading18.copyWith(color: kPrimaryColor),
                    ),
                    SizedBox(height: displayHeight(context) * 0.02),
                    Row(
                      children: [
                        SizedBox(width: displayWidth(context) * 0.01),
                        GestureDetector(
                          child: Container(
                            width: displayWidth(context) * 0.4,
                            decoration: BoxDecoration(
                                color: petType == 'Dog'
                                    ? Colors.lightGreen[100]
                                    : kWhiteBackgroundColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding:
                                  EdgeInsets.all(displayWidth(context) * 0.05),
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  Image.asset(
                                    'assets/images/dog.png',
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Dog',
                                    style: kHeading16.copyWith(
                                        color: kPrimaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              if (null != petType && petType == 'Cat')
                                selectedBreed = '';
                              petType = 'Dog';
                            });
                          },
                        ),
                        SizedBox(width: displayWidth(context) * 0.05),
                        GestureDetector(
                          child: Container(
                            width: displayWidth(context) * 0.4,
                            decoration: BoxDecoration(
                                color: petType == 'Cat'
                                    ? Colors.lightGreen[100]
                                    : kWhiteBackgroundColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding:
                                  EdgeInsets.all(displayWidth(context) * 0.05),
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  Image.asset(
                                    'assets/images/cat (2).png',
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Cat',
                                    style: kHeading16.copyWith(
                                        color: kPrimaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              if (null != petType && petType == 'Dog')
                                selectedBreed = '';
                              petType = 'Cat';
                            });
                          },
                        ),
                      ],
                    ),

                    /**Custom Drop down list */
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: displayWidth(context) * 0.01,
                          vertical: displayHeight(context) * 0.02),
                      child: Container(
                        height: displayHeight(context) * 0.068,
                        width: displayWidth(context) * 0.85,
                        decoration: kBoxDecoration(),
                        child: CustomSearchTextBox(
                          borderColor: null,
                          textSize: 16,
                          textColor: selectedBreed == ''
                              ? kPrimaryColor
                              : kPrimaryColor,
                          text: selectedBreed == '' ? 'Breed' : selectedBreed,
                          onPressed: () async {
                            final result = await showSearch(
                              context: context,
                              delegate: CustomSearchDelegate(
                                searchDelegateBloc: SearchDelegateBloc(),
                                loadSuggestions: ApiRepository().getBreedList,
                                dropdownOnly: true,
                                tag: petType,
                                accessToken: LocalDb.userAccessToken,
                              ),
                            );
                            setState(() {
                              if (result != null && result != '')
                                selectedBreed = result;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: displayWidth(context) * 0.01,
                      ),
                      child: Container(
                        height: displayHeight(context) * 0.068,
                        width: displayWidth(context) * 0.85,
                        decoration: kBoxDecoration(),
                        child: DateTimePicker(
                          style: kHeading16.copyWith(color: kPrimaryColor),
                          decoration: InputDecoration(
                            focusColor: primaryTextColor,
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            hintText: "Birthday",
                            hintStyle:
                                kHeading16.copyWith(color: kPrimaryColor),
                            contentPadding: EdgeInsets.only(
                                left: 15.0, bottom: 8.0, top: 10.0),
                          ),
                          initialValue: "",
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                          dateLabelText: 'Birthday',
                          onChanged: (val) {
                            setState(() {
                              _dob = DateTime.parse(val);
                            });
                          },
                          validator: (val) {
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: displayWidth(context) * 0.01,
                        vertical: displayHeight(context) * 0.02,
                      ),
                      child: Container(
                        height: displayHeight(context) * 0.068,
                        width: displayWidth(context) * 0.85,
                        decoration: kBoxDecoration(),
                        child: Row(
                          children: [
                            SizedBox(
                              width: displayWidth(context) * 0.04,
                            ),
                            Text(
                              "Gender:",
                              style: kHeading16.copyWith(color: kPrimaryColor),
                            ),
                            RadioGroup<String>.builder(
                              direction: Axis.horizontal,
                              horizontalAlignment: MainAxisAlignment.start,
                              groupValue: selectedGender,
                              onChanged: (value) => setState(() {
                                selectedGender = value;
                              }),
                              items: _status,
                              itemBuilder: (item) => RadioButtonBuilder(
                                item,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    PrimaryButton(
                      title: 'Next',
                      onPressed: () => {
                        onNextPressed(context),
                      },
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
