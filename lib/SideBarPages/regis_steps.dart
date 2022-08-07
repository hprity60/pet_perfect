import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_perfect_app/SideBarPages/models/pet_registration.dart';
import 'package:pet_perfect_app/common/models/user_data.dart';
import 'package:pet_perfect_app/common/widgets/custom_text_box.dart';
import 'package:pet_perfect_app/repositories/api_repository.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';

import 'package:geolocator/geolocator.dart';

class RegistrationSteps extends StatefulWidget {
  PetRegistrationModel petRegistrationModel;
  RegistrationSteps(this.petRegistrationModel);
  @override
  _RegistrationStepsState createState() => _RegistrationStepsState();
}

class _RegistrationStepsState extends State<RegistrationSteps> {
  List<String> _status = ["Male", "Female"];
  String selectedGender;
  int _currentState = 0;
  Position _currentPosition;

  final _scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: 'regis steps');
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  final petNameController = TextEditingController();
  final breedController = TextEditingController();
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  //address controllers
  final houseController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pinController = TextEditingController();

  File _image;
  bool loadingData = true;
  final picker = ImagePicker();
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

  _validateSteps(BuildContext context) {
    if (_currentState == 0) {
      _validateStep1(_currentState);
    } else if (_currentState == 1) {
      _validateStep2(_currentState);
    } else {
      _validateStep3(_currentState);
    }
  }

  _validateStep2(int step) {
    if (mobileController.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Please Provide Your Mobile Number!!'),
        backgroundColor: kredBackgroundColor,
      ));
    } else if (phoneController.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Please Provide Your Phone Number!'),
        backgroundColor: kredBackgroundColor,
      ));
    } else if (emailController.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Please Provide Your Email!'),
        backgroundColor: kredBackgroundColor,
      ));
    } else {
      if (_currentState < this._steppers().length - 1) {
        setState(() {
          _currentState = _currentState + 1;
        });
      }
    }
  }

  setData() {
    petNameController.text = widget.petRegistrationModel.petName;
    breedController.text = widget.petRegistrationModel.breed;
    userNameController.text = widget.petRegistrationModel.userName;
    phoneController.text = widget.petRegistrationModel.phone;
    mobileController.text = widget.petRegistrationModel.mobile;
    emailController.text = widget.petRegistrationModel.email;
    houseController.text = widget.petRegistrationModel.house;
    streetController.text = widget.petRegistrationModel.street;
    cityController.text = widget.petRegistrationModel.city;
    stateController.text = widget.petRegistrationModel.state;
    pinController.text = widget.petRegistrationModel.pinCode;
    // _image = widget.petRegistrationModel.image;
  }

  _validateStep3(int step) {
    if (houseController.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Please Provide Your House/Flat No.'),
        backgroundColor: kredBackgroundColor,
      ));
    } else if (streetController.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Please Provide Your Street'),
        backgroundColor: kredBackgroundColor,
      ));
    } else if (cityController.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Please Provide Your City'),
        backgroundColor: kredBackgroundColor,
      ));
    } else if (stateController.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Please Provide Your State'),
        backgroundColor: kredBackgroundColor,
      ));
    } else if (pinController.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Please Provide Your Pincode'),
        backgroundColor: kredBackgroundColor,
      ));
    } else {
      PetRegistrationModel petRegistrationModel = PetRegistrationModel(
        breed: breedController.text,
        city: cityController.text,
        email: emailController.text,
        gender: selectedGender,
        house: houseController.text,
        mobile: mobileController.text,
        petName: petNameController.text,
        phone: phoneController.text,
        state: stateController.text,
        pinCode: pinController.text,
        street: streetController.text,
        userName: userNameController.text,
        image: _image,
        status: 'Applied',
      );
      ApiRepository().savePetRegistrationDetails(petRegistrationModel);
      Navigator.of(context).pop();
    }
  }

  _validateStep1(int step) {
    if (petNameController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please provide your pet name!",
          backgroundColor: kredBackgroundColor);
    } else if (breedController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please Provide Your Pet Breed!",
          backgroundColor: kredBackgroundColor);
    } else if (_image == null) {
      Fluttertoast.showToast(
          msg: "Please Provide Your Pet's Image",
          backgroundColor: kredBackgroundColor);
    } else {
      if (_currentState < this._steppers().length - 1) {
        setState(() {
          _currentState = _currentState + 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // petNameController.text = UserData.user.petName;
    // breedController.text = UserData.user.breed;
    // // userNameController.text =
    // //     (UserData.user.firstName + " " + UserData.user.lastName).toString();
    // mobileController.text = UserData.user.phoneNumber == null
    //     ? ''
    //     : UserData.user.phoneNumber.toString();
    // phoneController.text = UserData.user.phoneNumber == null
    //     ? ''
    //     : UserData.user.phoneNumber.toString();
    // selectedGender = UserData.user.gender;

    // print(UserData.user.parentName);
    // print(UserData.user.phoneNumber);

    setData();
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0,
          title: Text('Pet registration'),
        ),
        backgroundColor: kCustomWhiteColor,
        body: Stepper(
          steps: _steppers(),
          type: StepperType.horizontal,
          currentStep: _currentState,
          onStepTapped: (step) {
            setState(() {
              _currentState = step;
            });
          },
          onStepContinue: () {
            _validateSteps(context);
           
          },
          onStepCancel: () {
            setState(() {
              if (_currentState > 0) {
                _currentState = _currentState - 1;
              } else {
                _currentState = 0;
              }
            });
          },
          physics: ClampingScrollPhysics(),
        ));
  }

  List<Step> _steppers() {
    List<Step> _steps = [
      Step(
        // state: StepState.indexed,
        state: _currentState > 0 ? StepState.complete : StepState.disabled,
        isActive: _currentState >= 0,

        title: Text('Pet'),
        content: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  child: InkWell(
                    onTap: () {
                      selectImage(context);
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: _image == null
                          ? UserData.user.petImage != null
                              ? Image.file(UserData.user.petImage)
                              : Image.asset('assets/images/cat profile.png')
                          : null,
                      backgroundImage:
                          _image == null ? null : FileImage(_image),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            CustomTextBox(
              // hintText: 'Name of Pet',
              labelText: 'Name of Pet',
              textInputType: TextInputType.name,
              obscureText: false,
              textEditingController: petNameController,
            ),
            CustomTextBox(
              // hintText: 'Breed',
              labelText: 'Breed',
              textInputType: TextInputType.name,
              obscureText: false,
              textEditingController: breedController,
            ),
            Container(
              height: displayHeight(context) * 0.08,
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
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                      print(value);
                    },
                    items: _status,
                    itemBuilder: (item) => RadioButtonBuilder(
                      item,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Step(
          // state: StepState.indexed,
          state: _currentState > 1 ? StepState.complete : StepState.disabled,
          isActive: _currentState >= 1,
          title: Text("Pet owner"),
          content: Column(
            children: [
              CustomTextBox(
                // hintText: 'Applicant Name',
                labelText: 'Applicant Name',
                textInputType: TextInputType.name,
                obscureText: false,
                textEditingController: userNameController,
              ),
              CustomTextBox(
                // hintText: 'Phone Number',
                labelText: 'Phone Number',
                textInputType: TextInputType.name,
                obscureText: false,

                textEditingController: phoneController,
              ),
              CustomTextBox(
                // hintText: 'Mobile Number',
                labelText: 'Mobile Number',
                // enabled: false,
                textInputType: TextInputType.name,
                obscureText: false,
                textEditingController: mobileController,
              ),
              CustomTextBox(
                // hintText: 'Email Id',
                labelText: 'Email Id',
                textInputType: TextInputType.name,
                obscureText: false,
                textEditingController: emailController,
              ),
            ],
          )),
      Step(
          // state: StepState.indexed,

          state: _currentState > 2 ? StepState.complete : StepState.disabled,
          isActive: _currentState >= 2,
          title: Text('Address'),
          content: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset('assets/images/current_location.png'),
                  SizedBox(width: 5),
                  FlatButton(
                    onPressed: () {
                      _getCurrentLocation();
                    },
                    child: Text(
                      'Use Current location',
                      style: kHeading11,
                    ),
                  ),
                ],
              ),
              CustomTextBox(
                // hintText: 'Plot/House No',
                labelText: 'Plot/House No',
                textInputType: TextInputType.name,
                obscureText: false,
                textEditingController: houseController,
              ),
              CustomTextBox(
                // hintText: 'Street Name',
                labelText: 'Street Name',
                textInputType: TextInputType.name,
                obscureText: false,
                textEditingController: streetController,
              ),
              CustomTextBox(
                // hintText: 'City',
                labelText: 'City',
                textInputType: TextInputType.name,
                obscureText: false,
                textEditingController: cityController,
              ),
              CustomTextBox(
                // hintText: 'State',
                labelText: 'State',
                textInputType: TextInputType.name,
                obscureText: false,
                textEditingController: stateController,
              ),
              CustomTextBox(
                // hintText: 'Pincode',
                labelText: 'Pincode',
                textInputType: TextInputType.name,
                obscureText: false,
                textEditingController: pinController,
              ),
            ],
          )),
    ];
    return _steps;
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      print('place is : ${place.postalCode}');
      print('locality is : ${place.locality}');
      print('thoroughfare is : ${place.thoroughfare}');
      print('country is : ${place.country}');
      print('subLocality is : ${place.subLocality}');
      print('administrativeArea is : ${place.administrativeArea}');
      print('administrativeArea is : ${place.subAdministrativeArea}');

      setState(() {
        pinController.text = place.postalCode;
        cityController.text = place.country;
        stateController.text = place.administrativeArea;
        streetController.text = place.subLocality;
      });
    } catch (e) {
      print(e);
    }
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }
}
