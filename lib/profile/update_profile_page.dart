import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_perfect_app/common/widgets/loading_indicator.dart';
import 'package:pet_perfect_app/common/widgets/zoomImage.dart';
import 'package:pet_perfect_app/home/bloc/export.dart';
import 'package:pet_perfect_app/home/models/filePicture.dart';
import 'package:pet_perfect_app/home/models/picture.dart';
import 'package:pet_perfect_app/repositories/api_repository.dart';
import 'package:pet_perfect_app/screens/components/category_button.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:intl/intl.dart';

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  List<Picture> pictures;
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is PictureDataLoading) {
          loadingData = true;
        } else if (state is PictureDataLoaded) {
          loadingData = false;
          pictures = state.petRecordsAndNotes.pictures;
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Update Pictures",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              elevation: 0,
              backgroundColor: kPrimaryColor,
            ),
            backgroundColor: kCustomWhiteColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      width: displayWidth(context),
                      decoration: kBackgroundBoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    //on tap heerre
                                    selectImage(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: _image != null
                                        ? Column(
                                            children: [
                                              // Card(
                                              //   child: Container(
                                              //       height: 200,
                                              //       width: 200,
                                              //       child: Image.file(_image)),
                                              // ),
                                              CircleAvatar(
                                                radius: 65,
                                                backgroundImage:
                                                    FileImage(_image),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              CategoryButton(
                                                textColor: Colors.white,
                                                bgColor: kPrimaryColor,
                                                text: 'Add Picture',
                                                press: () {
                                                  print('add pic');
                                                  Picture pic = Picture(
                                                      file: _image,
                                                      date: DateTime.now(),
                                                          );
                                                  setState(() {
                                                    pictures.add(pic);
                                                    _image = null;
                                                  });

                                                  FilePicture picture =
                                                      FilePicture();
                                                  //save image by calling api
                                                  ApiRepository()
                                                      .savePicture(picture);
                                                  // pictures.add(picture);
                                                },
                                              ),
                                            ],
                                          )
                                        : CircleAvatar(
                                            backgroundColor: kCustomWhiteColor,
                                            radius: 60,
                                            backgroundImage: AssetImage(
                                              'assets/images/update.png',
                                              // fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Pictures History',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 16),
                            loadingData
                                ? LoadingIndicator()
                                : GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 10,
                                    ),
                                    itemCount: pictures.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return _buildPictures(
                                        url: pictures[index].url,
                                        // date: pictures[index].date,
                                        date: DateFormat.yMd().format(pictures[index].date),
                                        fileImage: pictures[index].file,
                                      );
                                    },
                                  ),
                          ],
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
    );
  }

  _buildPictures({String url, String date, File fileImage}) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ZoomImage(
                      imageUrl: url,
                      imageFile: fileImage,
                    )));
          },
          child: Container(
            height: 140,
            color: Colors.blue,
            // aspectRatio: 1.15,
            child: url != null
                ? Image.network(
                    url,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    fileImage,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Text(
          date,
          style: GoogleFonts.poppins(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
