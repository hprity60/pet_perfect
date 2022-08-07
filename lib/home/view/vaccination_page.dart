import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/common/models/user_data.dart';
import 'package:pet_perfect_app/common/widgets/loading_indicator.dart';
import 'package:pet_perfect_app/home/bloc/export.dart';
import 'package:pet_perfect_app/home/export.dart';
import 'package:pet_perfect_app/home/models/deworming.dart';
import 'package:pet_perfect_app/home/models/vaccination.dart';
import 'package:pet_perfect_app/home/view/edit_deworming_page.dart';
import 'package:pet_perfect_app/home/view/edit_vaccination_page.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/home/components/chart.dart';

class VaccinationpPage extends StatefulWidget {
  @override
  _VaccinationpPageState createState() => _VaccinationpPageState();
}

class _VaccinationpPageState extends State<VaccinationpPage> {
  List<Vaccination> vaccinations;
  List<Deworming> dewormings;
  bool _loadingData = true;
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is VaccinationState) {
          vaccinations = UserData.user.getVaccination().pendingVaccination +
              UserData.user.getVaccination().upcomingVaccination +
              UserData.user.getVaccination().completedVaccination;
          dewormings = UserData.user.getDeworming().pendingDeworming +
              UserData.user.getDeworming().upcomingDeworming +
              UserData.user.getDeworming().completedDeworming;
          _loadingData = false;
        }
        if (state is EditDewormingState) {
          _loadingData = false;
          dewormings = state.dewormings;
        }
        // if (state is EditVaccinationState) {
        //   _loadingData = false;
        //   vaccinations = state.vaccinations;
        // }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          print("vaccination running again");

          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  "Vaccination & Deworming",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                elevation: 0,
                backgroundColor: kPrimaryColor,
              ),
              backgroundColor: kCustomWhiteColor,
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    verticalDirection: VerticalDirection.down,
                    children: [
                      SingleChildScrollView(
                        child: Container(
                          height: displayHeight(context) * 0.9,
                          width: double.infinity,
                          decoration: kBackgroundBoxDecoration(),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              verticalDirection: VerticalDirection.down,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 16),
                                      Column(
                                        children: [
                                          Container(
                                            height:
                                                displayHeight(context) * 0.07,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(7.0),
                                              child: Expanded(
                                                                                              child: TabBar(
                                                  labelColor: Colors.white,
                                                  unselectedLabelColor:
                                                      kPrimaryColor,
                                                  labelStyle: GoogleFonts.poppins(
                                                      fontSize: 14),
                                                  indicator: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: kPrimaryColor),
                                                  tabs: [
                                                    Tab(
                                                      text: 'Vaccination',
                                                    ),
                                                    Tab(
                                                      text: 'Deworming',
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16),
                                if (vaccinations == null)
                                  Center(child: Text('vaccinations is null'))
                                else
                                  _loadingData
                                      ? LoadingIndicator()
                                      : SingleChildScrollView(
                                          child: 
                                          SizedBox(
                                            height:  displayHeight(context)*5,
                                            child: 
                                            TabBarView(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 16),
                                                  child: Container(
                                                    height:
                                                        displayHeight(context),
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 12,
                                                          vertical: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  'Vaccination',
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                'Date/Age',
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Text(
                                                                      'Status',
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          ListView.builder(
                                                              shrinkWrap: true,
                                                              physics: NeverScrollableScrollPhysics(),
                                                              itemCount:
                                                                  vaccinations
                                                                      .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return Chart(
                                                                  text1: vaccinations[
                                                                          index]
                                                                      .name,
                                                                  text2: vaccinations[
                                                                          index]
                                                                      .date,
                                                                  text3: vaccinations[
                                                                          index]
                                                                      .status,
                                                                  color1: Colors
                                                                      .black,
                                                                  color2: Colors
                                                                      .black,
                                                                );
                                                              }),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(MaterialPageRoute(
                                                                          builder:
                                                                              (_) {
                                                                    return BlocProvider.value(
                                                                        value: BlocProvider.of<HomeBloc>(
                                                                            context),
                                                                        child:
                                                                            EditVaccinationpPage());
                                                                  }));
                                                                },
                                                                child: Chip(
                                                                  backgroundColor:
                                                                      kPrimaryColor,
                                                                  label: Text(
                                                                    'Edit Status',
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 10),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 20,
                                                  ),
                                                  child: Container(
                                                    height:
                                                        displayHeight(context) *
                                                            0.6,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10,
                                                          vertical: 10),
                                                      child: BlocBuilder<
                                                          HomeBloc, HomeState>(
                                                        builder: (ctx, state) {
                                                          return Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    'Age',
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'Date',
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'Status',
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              ListView.builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemCount:
                                                                      dewormings
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return Chart(
                                                                      text1: dewormings[
                                                                              index]
                                                                          .age,
                                                                      text2: dewormings[
                                                                              index]
                                                                          .date,
                                                                      text3: dewormings[
                                                                              index]
                                                                          .status,
                                                                      color1: Colors
                                                                          .black,
                                                                      color2: Colors
                                                                          .black,
                                                                    );
                                                                  }),
                                                              SizedBox(
                                                                  height: 10),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      // Navigator.of(
                                                                      //         context)
                                                                      //     .push(MaterialPageRoute(
                                                                      //         builder: (_) =>
                                                                      //             EditDewormingPage()));

                                                                      Navigator.of(
                                                                              context)
                                                                          .push(MaterialPageRoute(builder:
                                                                              (_) {
                                                                        return BlocProvider.value(
                                                                            value:
                                                                                BlocProvider.of<HomeBloc>(context),
                                                                            child: EditDewormingPage());
                                                                      }));
                                                                    },
                                                                    child: Chip(
                                                                      backgroundColor:
                                                                          kPrimaryColor,
                                                                      label:
                                                                          Text(
                                                                        'Edit Status',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.white,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          10),
                                                                ],
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      ),
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
