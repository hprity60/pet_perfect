import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/SideBarPages/models/pet_registration.dart';
import 'package:pet_perfect_app/common/bloc/pet_registration_bloc/pet_registration_bloc.dart';
import 'package:pet_perfect_app/common/bloc/pet_registration_bloc/pet_registration_state.dart';
import 'package:pet_perfect_app/common/widgets/loading_indicator.dart';
import 'package:pet_perfect_app/common/widgets/zoomImage.dart';
import 'package:pet_perfect_app/repositories/api_repository.dart';
import 'package:pet_perfect_app/screens/components/profile_bio_list.dart';
import 'package:pet_perfect_app/screens/components/side_bar.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';

class ViewProfilePage extends StatefulWidget {
  final userImage;
  final userName;
  const ViewProfilePage({
    this.userImage,
    this.userName,
  });
  @override
  _ViewProfilePageState createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  bool loadingData = true;
  bool isEditable = false;
  TextEditingController status = TextEditingController();
  TextEditingController registrationId = TextEditingController();
  TextEditingController petName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController address = TextEditingController();
  String city;
  String stateAddress;
  String house;
  String street;
  String pinCode;
  String buttonText;
  File _image;
  bool showLoading = false;
  String userImage;
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<PetRegistrationBloc, PetRegistrationState>(
      listener: (context, state) {
        if (state is PetRegistrationLoadingState) {
          loadingData = true;
        }
        if (state is PetRegistrationLoadedState) {
          stateAddress = state.petRegistrationDetails.state;
          city = state.petRegistrationDetails.city;
          house = state.petRegistrationDetails.house;
          street = state.petRegistrationDetails.street;
          pinCode = state.petRegistrationDetails.pinCode;

          address.text = "$house $street $city $stateAddress $pinCode";
          status.text = state.petRegistrationDetails.status;
          userName.text = state.petRegistrationDetails.userName;
          mobile.text = state.petRegistrationDetails.mobile;
          email.text = state.petRegistrationDetails.email;
          userImage = state.petRegistrationDetails.userImage;
          loadingData = false;
        }
      },
      child: BlocBuilder<PetRegistrationBloc, PetRegistrationState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Personal Profile",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              elevation: 0,
              backgroundColor: kPrimaryColor,
              
            ),
            backgroundColor: kPrimaryColor,
            body: loadingData
                ? LoadingIndicator()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          child: Container(
                            height: displayHeight(context) * 0.88,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: kSecondaryColor,
                            ),
                            child: Column(
                              children: [
                                
                                SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20,vertical: 20),
                                    child: Column(
                                      children: [
                                        // FlatButton(
                                        //   onPressed: () {
                                        //     if (isEditable)
                                        //       getImage();
                                        //   },
                                        //   child: CircleAvatar(
                                        //     radius: 60,
                                        //     backgroundColor:
                                        //         kWhiteBackgroundColor,
                                        //     backgroundImage: _image == null
                                        //         ? NetworkImage(userImage)
                                        //         : FileImage(_image),
                                        //   ),
                                        // ),

                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Stack(
                                                alignment:
                                                    Alignment.bottomRight,
                                                children: [
                                                  FlatButton(
                                                    visualDensity:
                                                        VisualDensity.compact,
                                                    onPressed: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  ZoomImage(
                                                                    imageFile:
                                                                        _image,
                                                                    imageUrl:
                                                                        userImage,
                                                                  )));
                                                    },
                                                    child: CircleAvatar(
                                                        backgroundColor:
                                                            kWhiteBackgroundColor,
                                                        radius: 60,
                                                        backgroundImage:
                                                            _image == null
                                                                ? NetworkImage(
                                                                    userImage)
                                                                : FileImage(
                                                                    _image)),
                                                  ),
                                                  Container(
                                                    height: 28,
                                                    child: isEditable
                                                        ? FloatingActionButton(
                                                            elevation: 4,
                                                            backgroundColor:
                                                                Color(
                                                                    0xffE25E60),
                                                            onPressed: () {
                                                              if (isEditable)
                                                                selectImage(
                                                                    context);
                                                            },
                                                            child: Icon(
                                                              Icons.add,
                                                            ))
                                                        : Text(""),
                                                  )
                                                ])
                                          ],
                                        ),

                                        SizedBox(height: 15),
                                        GestureDetector(
                                          onTap: () {
                                            if (isEditable) {
                                              PetRegistrationModel data =
                                                  PetRegistrationModel(
                                                userName: userName.text,
                                                mobile: mobile.text,
                                                email: email.text,
                                              );
                                              ApiRepository()
                                                  .savePetRegistrationDetails(
                                                      data);
                                              setState(() {
                                                isEditable = false;
                                              });
                                            } else {
                                              setState(() {
                                                isEditable = true;
                                              });
                                            }
                                          },
                                          child: Chip(
                                            label: Text(
                                              isEditable
                                                  ? 'Save Profile'
                                                  : 'Edit Profile',
                                              style: kHeading14.copyWith(
                                                  color: Colors.white),
                                            ),
                                            backgroundColor: kPrimaryColor,
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        Container(
                                          // height: displayHeight(context) * 0.99,
                                          width: double.infinity,
                                          decoration: kBox12Decoration(),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                ProfileBioList(
                                                  text1: 'Name',
                                                  textEditingController:
                                                      userName,
                                                  isEditable: isEditable,
                                                ),
                                                SizedBox(height: 10),
                                                ProfileBioList(
                                                  text1: 'Mobile',
                                                  // text2: '$mobile',
                                                  textEditingController: mobile,
                                                  isEditable: isEditable,
                                                ),
                                                SizedBox(height: 10),
                                                ProfileBioList(
                                                  text1: 'Email',
                                                  // text2: '$email',
                                                  textEditingController: email,
                                                  isEditable: isEditable,
                                                ),
                                                SizedBox(height: 10),
                                                ProfileBioList(
                                                  text1: 'Address',
                                                  // text2:
                                                  //     '$house $street $city $stateAddress $pinCode',
                                                  isEditable: isEditable,
                                                  textEditingController:
                                                      address,
                                                ),
                                              ],
                                            ),
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
        },
      ),
    );
  }
}
