import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pet_perfect_app/common/models/user_data.dart';
import 'package:pet_perfect_app/home/bloc/export.dart';
import 'package:pet_perfect_app/home/models/deworming.dart';
import 'package:pet_perfect_app/repositories/api_repository.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';

class EditDewormingPage extends StatefulWidget {
  @override
  _EditDewormingPageState createState() => _EditDewormingPageState();
}

class _EditDewormingPageState extends State<EditDewormingPage> {
  List<Deworming> dewormings = UserData.user.getDeworming().pendingDeworming +
      UserData.user.getDeworming().upcomingDeworming +
      UserData.user.getDeworming().completedDeworming;
  Set dewormingChangedSet = Set();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Deworming",
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
                height: displayHeight(context) * 0.87,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    itemCount: dewormings.length,
                                    itemBuilder: (context, index) {
                                      return _buildChart(
                                        text1: dewormings[index].age.toString(),
                                        date: dewormings[index].date,
                                        text3: dewormings[index].status,
                                        color1: Colors.black,
                                        color2: Colors.black,
                                        index: index,
                                      );
                                    }),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        List<Map> dewormingChangedList =
                                            List<Map>();

                                        dewormingChangedSet.forEach((element) {
                                          dewormingChangedList.add({
                                            "age": dewormings[element].age,
                                            "status":
                                                dewormings[element].status,
                                          });
                                        });
                                        BlocProvider.of<HomeBloc>(context).add(
                                            EditDewormingEvent(
                                                dewormings,
                                                dewormingChangedList,
                                                UserData.user.petId));

                                        dewormingChangedSet.clear();

                                        Navigator.of(context).pop();
                                      },
                                      child: Chip(
                                        backgroundColor: kPrimaryColor,
                                        label: Text(
                                          'Save Changes',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
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
  }

  void _handleStatus(int index) {
    if (dewormings[index].status == 'PENDING') {
      setState(() {
        dewormings[index].status = 'COMPLETED';
        print("done");
      });
    } else if (dewormings[index].status == 'COMPLETED') {
      setState(() {
        dewormings[index].status = 'PENDING';
        print("done");
      });
    }
  }

  Widget _buildChart(
      {String text1,
      DateTime date,
      String text3,
      Color color1,
      Color color2,
      int index}) {
    Color color3;
    if (text3 == 'PENDING') {
      color3 = Colors.red;
    } else if (text3 == 'COMPLETED') {
      color3 = Colors.green;
    } else if (text3 == 'UPCOMING') {
      color3 = Colors.yellow;
    }
    return Container(
      // height: 60,
      width: double.infinity,
      child: Column(
        children: [
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text1,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: color1,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                DateFormat.yMd().format(date),
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: color2,
                  fontWeight: FontWeight.w400,
                ),
              ),
              FlatButton(
                color: color3,
                height: 27,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {
                  dewormingChangedSet.add(index);
                  _handleStatus(index);
                },
                child: Text(
                  text3,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}