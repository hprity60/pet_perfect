import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pet_perfect_app/common/widgets/loading_indicator.dart';
import 'package:pet_perfect_app/common/widgets/zoomImage.dart';
import 'package:pet_perfect_app/home/models/picture.dart';
import 'package:pet_perfect_app/profile/bloc/pet_profile_bloc.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';

class DocumentPage extends StatefulWidget {
  @override
  _DocumentPageState createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  bool _loadingData = true;
  List<Picture> pictures = [];
  List<Picture> pictures2 = [];
  List<Picture> pictures3 = [];
  File _medicalImage;
  File _registrationImage;
  File _otherImage;
  final date = DateFormat.yMMMMd().format(DateTime.now());

  final picker = ImagePicker();
  
  final picker2 = ImagePicker();
  final picker3 = ImagePicker();
  Future getImage(ImageSource source, File imageType, List<Picture> list,
      BuildContext ctx) async {
    print('imageType is $imageType');
    Navigator.pop(ctx);

    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        imageType = File(pickedFile.path);
        final pic = Picture(date: DateTime.now(), file: imageType);
        list.add(pic);
      } else {
        Fluttertoast.showToast(msg: "No Image selected!");
      }
    });
  }

  selectImage(BuildContext ctx, File imageType, List<Picture> list) {
    return showDialog(
        context: ctx,
        builder: (ctx) {
          return SimpleDialog(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            title: Text('Upload Image'),
            children: <Widget>[
              SimpleDialogOption(
                child: Text('Choose from Camera'),
                onPressed: () =>
                    getImage(ImageSource.camera, imageType, list, ctx),
              ),
              SimpleDialogOption(
                child: Text('Choose from Gallery'),
                onPressed: () =>
                    getImage(ImageSource.gallery, imageType, list, ctx),
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
    return BlocConsumer<PetProfileBloc, PetProfileState>(
      listener: (context, state) {
        if (state is PetProfileLoadingState) _loadingData = true;
        if (state is PetProfileLoadedState) {
          _loadingData = false;
          pictures = state.petProfile.documents.medicalPrescriptions;
          pictures2 = state.petProfile.documents.registrationDocuments;
          pictures3 = state.petProfile.documents.certifications;
        }
      },
      builder: (context, state) {
        if (state is PetProfileLoadedState) {
          _loadingData = false;

          pictures = state.petProfile.documents.medicalPrescriptions;
          pictures2 = state.petProfile.documents.registrationDocuments;
          pictures3 = state.petProfile.documents.certifications;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Pet Perfect",
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
                    // height: displayHeight(context) * 0.9,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(23),
                        topRight: Radius.circular(23),
                      ),
                    ),
                    child: Column(
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
                              "Documents",
                              style: GoogleFonts.poppins(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Container(
                                  // height: displayHeight(context) * 0.8,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Medical Prescription',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            FlatButton(
                                              onPressed: () {
                                                selectImage(context,
                                                    _medicalImage, pictures);
                                              },
                                              child: Text(
                                                'Add New',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    color: kPrimaryColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        _loadingData
                                            ? LoadingIndicator()
                                            : GridView.builder(
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  // childAspectRatio: 1,
                                                  mainAxisSpacing: 5,
                                                  crossAxisSpacing: 5,
                                                ),
                                                itemCount: pictures.length,
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return _buildPictures(
                                                      pictures[index].url,
                                                      // pictures[index].date,
                                                      DateFormat.yMd().format(pictures[index].date),
                                                      pictures[index].file);
                                                },
                                              ),
                                        SizedBox(height: 15),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Registration Documents',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            FlatButton(
                                              onPressed: () {
                                                selectImage(
                                                    context,
                                                    _registrationImage,
                                                    pictures2);
                                              },
                                              child: Text(
                                                'Add New',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    color: kPrimaryColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        _loadingData
                                            ? LoadingIndicator()
                                            : GridView.builder(
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  // childAspectRatio: 1,
                                                  mainAxisSpacing: 5,
                                                  crossAxisSpacing: 5,
                                                ),
                                                itemCount: pictures2.length,
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return _buildPictures(
                                                      pictures2[index].url,
                                                      // pictures2[index].date,
                                                      DateFormat.yMd().format(pictures2[index].date),
                                                      pictures2[index].file);
                                                },
                                              ),
                                        SizedBox(height: 15),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Certifications',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            FlatButton(
                                              onPressed: () {
                                                selectImage(context,
                                                    _otherImage, pictures3);
                                              },
                                              child: Text(
                                                'Add New',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    color: kPrimaryColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        _loadingData
                                            ? LoadingIndicator()
                                            : GridView.builder(
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 1,
                                                  mainAxisSpacing: 15,
                                                  crossAxisSpacing: 15,
                                                ),
                                                itemCount: pictures3.length,
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return _buildPictures(
                                                      pictures3[index].url,
                                                      // pictures3[index].date,
                                                      DateFormat.yMd().format(pictures3[index].date),
                                                      pictures3[index].file);
                                                },
                                              ),
                                      ],
                                    ),
                                  ),
                                )
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
    );
  }

  _buildPictures(String url, String text, File file) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ZoomImage(
                      imageUrl: url,
                      imageFile: file,
                    )));
          },
          child: Container(
            height: displayHeight(context) * 0.15,
            width: displayWidth(context) * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: file != null ? FileImage(file) : NetworkImage(url),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Text(text),
      ],
    );
  }
}