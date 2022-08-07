import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/common/bloc/pet_registration_bloc/pet_registration_bloc.dart';
import 'package:pet_perfect_app/common/bloc/pet_registration_bloc/pet_registration_state.dart';
import 'package:pet_perfect_app/common/widgets/loading_indicator.dart';
import 'package:pet_perfect_app/screens/components/registration_card.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/SideBarPages/regis_steps.dart';
import './models/pet_registration.dart';

class RegisScreen extends StatefulWidget {
  final userName;
  final userImage;
  const RegisScreen({
    this.userImage,
    this.userName,
  });
  @override
  _RegisScreenState createState() => _RegisScreenState();
}

class _RegisScreenState extends State<RegisScreen> {
  PetRegistrationModel _petRegistrationModel;
  bool loadingData = true;
  String status;
  Color statusColor;
  String registrationId;
  String petName;
  String userName;
  @override
  Widget build(BuildContext context) {
    return BlocListener<PetRegistrationBloc, PetRegistrationState>(
      listener: (context, state) {
        if (state is PetRegistrationLoadingState) {
          loadingData = true;
        }
        if (state is PetRegistrationLoadedState) {
          _petRegistrationModel = state.petRegistrationDetails;
          status = state.petRegistrationDetails.status;
          userName = state.petRegistrationDetails.userName;
          petName = state.petRegistrationDetails.petName;
          registrationId = state.petRegistrationDetails.registrationId;

          loadingData = false;
        }
      },
      child: BlocBuilder<PetRegistrationBloc, PetRegistrationState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Registration",
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
                      height: displayHeight(context) - 56,
                      width: double.infinity,
                      decoration: kBackgroundBoxDecoration(),
                      child: Column(
                        children: [
                          loadingData
                              ? LoadingIndicator()
                              : SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        _buildRegistrationCard(status, state),
                                        SizedBox(height: 32),
                                        Container(
                                          width: 120,
                                          height: 42,
                                          child: RaisedButton(
                                            color: kCustomYellowColor,
                                            onPressed: () {},
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  'Add New',
                                                  style: kHeading14.copyWith(
                                                      color: Colors.white),
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
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _buildRegistrationCard(String status, PetRegistrationState state) {
    if (status == 'Registered') {
      statusColor = Colors.green;
      return RegistrationCard(
        image: 'assets/images/profile.png',
        petName: 'Name: $userName',
        registrationId: 'Reg ID: $registrationId',
        ownerName: 'Owner: $userName',
      );
    } else if (status == "Applied") {
      statusColor = Colors.orange;
      return Text(status);
    } else if (status == "Not Registered") {
      statusColor = Colors.red;

      return _buildPetCard(status);
      // Chip(
      //   label: Text(
      //     '  Register Now  ',
      //     style: GoogleFonts.poppins(
      //       fontSize: 14,
      //       color: Colors.white,
      //       fontWeight: FontWeight.w400,
      //     ),
      //   ),
      //   backgroundColor: kPrimaryColor,
      // ),

    }
  }

  _buildPetCard(String status) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      color: kPrimaryColor,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                          child: CircleAvatar(
                        child: Image.network('assets/images/cat.png'),
                        radius: 40,
                      )),
                    ],
                  ),
                  Container(
                      child: VerticalDivider(
                    color: Colors.blue,
                    thickness: 2,
                  )),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name : $petName',
                        style: kHeading14,
                      ),
                      Text(
                        'Owner : $userName',
                        style: kHeading14,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text('Status : ',
                              style: kHeading14.copyWith(
                                  fontWeight: FontWeight.w600)),
                          Text(
                            status,
                            style: kHeading14.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      status != null
                          ? Row(
                              children: [
                                Text('Registration Id : ',
                                    style: kHeading14.copyWith(
                                        fontWeight: FontWeight.w600)),
                                Text(
                                  registrationId,
                                  style: kHeading14.copyWith(
                                      color: statusColor,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            )
                          : Container()
                    ],
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegistrationSteps(_petRegistrationModel)));
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Register Now',
                    style: kHeading16.copyWith(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
