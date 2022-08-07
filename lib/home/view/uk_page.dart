import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/common/models/user_data.dart';
import 'package:pet_perfect_app/home/bloc/export.dart';
import 'package:pet_perfect_app/home/export.dart';
import 'package:pet_perfect_app/home/models/vaccination.dart';
import 'package:pet_perfect_app/home/view/edit_vaccination_page.dart';
import 'package:pet_perfect_app/screens/components/side_bar.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/home/components/chart.dart';

class VaccinationPage extends StatefulWidget {
  @override
  _VaccinationPageState createState() => _VaccinationPageState();
}

class _VaccinationPageState extends State<VaccinationPage> {
  List<Vaccination> vaccinations =
      UserData.user.getVaccination().pendingVaccination +
          UserData.user.getVaccination().upcomingVaccination +
          UserData.user.getVaccination().completedVaccination;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {},
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            drawer: SideBar(),
            appBar: AppBar(
              title: Text(
                "Pet Perfect",
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
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                verticalDirection: VerticalDirection.down,
                children: [
                  SingleChildScrollView(
                    child: Container(
                      height: displayHeight(context) * 0.87,
                      width: double.infinity,
                      decoration: kBackgroundBoxDecoration(),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          verticalDirection: VerticalDirection.down,
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
                                  "Vaccination & Deworming",
                                  style: GoogleFonts.poppins(fontSize: 20),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  Container(
                                      height: 48,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Text("tab bar")
                                      //   Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.center,
                                      //     children: [
                                      //       SizedBox(width: 5),
                                      //       CategoryButton(
                                      //         press: () {},
                                      //         text: 'Vaccination',
                                      //         textColor: Colors.white,
                                      //         bgColor: kPrimaryColor,
                                      //       ),
                                      //       CategoryButton(
                                      //         press: () {
                                      //           Navigator.pushReplacement(
                                      //               context,
                                      //               MaterialPageRoute(
                                      //                   builder: (_) =>
                                      //                       BlocProvider.value(
                                      //                           value: BlocProvider
                                      //                               .of<HomeBloc>(
                                      //                                   context),
                                      //                           child:
                                      //                               DewormingPage())));
                                      //         },
                                      //         text: 'Deworming',
                                      //         textColor: kPrimaryColor,
                                      //         bgColor: Colors.white,
                                      //       ),
                                      //     ],
                                      //   ),
                                      ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Container(
                                height: displayHeight(context) * 0.8,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Vaccination',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            'Date/Age',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            'Status',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: vaccinations.length,
                                          itemBuilder: (context, index) {
                                            return Chart(
                                              text1: vaccinations[index].name,
                                              text2: vaccinations[index].date,
                                              text3: vaccinations[index].status,
                                              color1: Colors.black,
                                              color2: Colors.black,
                                            );
                                          }),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          EditVaccinationpPage()));
                                            },
                                            child: Chip(
                                              backgroundColor: kPrimaryColor,
                                              label: Text(
                                                'Edit Status',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Chip(
                                            backgroundColor: kPrimaryColor,
                                            label: Text(
                                              'Save Changes',
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
