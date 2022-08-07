import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/common/models/user_data.dart';
import 'package:pet_perfect_app/home/bloc/export.dart';
import 'package:pet_perfect_app/home/models/deworming.dart';
import 'package:pet_perfect_app/home/view/edit_deworming_page.dart';
import 'package:pet_perfect_app/screens/components/category_button.dart';
import 'package:pet_perfect_app/home/components/chart.dart';
import 'package:pet_perfect_app/home/view/vaccination_page.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';

class DewormingPage extends StatefulWidget {
  @override
  _DewormingPageState createState() => _DewormingPageState();
}

class _DewormingPageState extends State<DewormingPage> {
  List<Deworming> dewormings = UserData.user.getDeworming().pendingDeworming +
      UserData.user.getDeworming().upcomingDeworming +
      UserData.user.getDeworming().completedDeworming;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (ctx, state) {},
      child: Scaffold(
        // drawer: SideBar(),
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
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            children: [
              SingleChildScrollView(
                child: Container(
                  height: displayHeight(context),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      verticalDirection: VerticalDirection.down,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 5),
                                    CategoryButton(
                                      press: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    BlocProvider.value(
                                                        value: BlocProvider.of<
                                                            HomeBloc>(context),
                                                        child:
                                                            VaccinationpPage())));
                                      },
                                      text: 'Vaccination',
                                      textColor: kPrimaryColor,
                                      bgColor: Colors.white,
                                    ),
                                    CategoryButton(
                                      press: () {},
                                      text: 'Deworming',
                                      textColor: Colors.white,
                                      bgColor: kPrimaryColor,
                                    ),
                                  ],
                                ),
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
                            height: displayHeight(context) * 0.6,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: BlocBuilder<HomeBloc, HomeState>(
                                builder: (ctx, state) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Age',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            'Date',
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
                                          itemCount: dewormings.length,
                                          // physics: NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Chart(
                                              text1: dewormings[index].age,
                                              text2: dewormings[index].date,
                                              text3: dewormings[index].status,
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
                                                          EditDewormingPage()));
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
