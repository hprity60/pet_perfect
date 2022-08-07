import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/common/models/user_data.dart';
import 'package:pet_perfect_app/common/widgets/loading_indicator.dart';
import 'package:pet_perfect_app/home/components/topics_list.dart';
import 'package:pet_perfect_app/home/export.dart';
import 'package:pet_perfect_app/home/view/pet_record.dart';
import 'package:pet_perfect_app/profile/update_profile_page.dart';
import 'package:pet_perfect_app/repositories/api_repository.dart';
import 'package:pet_perfect_app/screens/components/default_search_box.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/home/models/vaccination.dart';
import 'package:pet_perfect_app/home/models/deworming.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/screens/components/side_bar.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './vaccination_page.dart';

class HomePage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loadingPetRecordsAndNotes = true;
  bool loadingTopicsData = true;
  final _notesController = TextEditingController();
  TopicsData _topicsData;
  String userName;
  String userImage;
  // buildPetRecords() {
  //   return InkWell(
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (_) => BlocProvider.value(
  //             value: BlocProvider.of<HomeBloc>(context),
  //             child: PetList(),
  //           ),
  //         ),
  //       );
  //     },
  //     child: Container(
  //       height: 88,
  //       width: double.infinity,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(8),
  //         color: Color(0xFFFAFDFF),
  //       ),
  //       child: !loadingPetRecordsAndNotes
  //           ? Row(
  //               children: [
  //                 SizedBox(width: 20),
  //                 Icon(
  //                   Icons.error_outline,
  //                   size: 50,
  //                   color: kPrimaryColor,
  //                 ),
  //                 SizedBox(width: 20),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     SizedBox(height: 5),
  //                     Text(
  //                       'Last Known',
  //                       style: GoogleFonts.poppins(
  //                         color: kPrimaryColor,
  //                       ),
  //                     ),
  //                     SizedBox(height: 5),
  //                     Text(
  //                       'Vaccination:  ${UserData.user.petRecordsAndNotes.vaccinations[0].name}',
  //                       style: GoogleFonts.poppins(
  //                         color: kPrimaryColor,
  //                       ),
  //                     ),
  //                     SizedBox(height: 5),
  //                     Text(
  //                       'Measurement:  ${UserData.user.petRecordsAndNotes.measurements[0].weight}kg',
  //                       style: GoogleFonts.poppins(
  //                         color: kPrimaryColor,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             )
  //           : LoadingIndicator(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is PetRecordsAndNotesLoadingState) {
          loadingPetRecordsAndNotes = true;
        }
        if (state is TopicsDataLoadingState) {
          loadingTopicsData = true;
        }
        if (state is PetRecordsAndNotesLoadedState) {
          UserData.user.savePetRecordsAndNotes(state.petRecordsAndNotes);
          _notesController.text = state.petRecordsAndNotes.notes;

          userName = state.petRegistration.userName;
          userImage = state.petRegistration.thumbnail;
          loadingPetRecordsAndNotes = false;
        }
        if (state is DataFailureState) {
          loadingPetRecordsAndNotes = false;
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(state.error),
            backgroundColor: Colors.red,
          ));
        }
        if (state is TopicsDataLoadedState) {
          loadingTopicsData = false;
          UserData.user.topicData = state.topicsData;
          _topicsData = state.topicsData;
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          print("notes is " + _notesController.text);
          return Scaffold(
            drawer: SideBar(userName: userName, userImage: userImage),
            appBar: AppBar(
              toolbarHeight: 56,
              title: Text(
                "Pet Perfect",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              elevation: 0,
              backgroundColor: kPrimaryColor,
              actions: [
                IconButton(
                    icon: SvgPicture.asset(
                      "assets/images/edit_notes.svg",
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            print('notes');
                            return _buildNotesDialog();
                          });
                    }),
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
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          // height: displayHeight(context) * 0.1,
                          width: double.infinity,
                          color: kPrimaryColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DefaultSearchBox(
                                  hintText: 'What are you looking for ?',
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        SingleChildScrollView(
                          child: Container(
                            // height: displayHeight(context) * 1.5,
                            width: displayWidth(context) * 99,
                            decoration: kBackgroundBoxDecoration(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildAds(),
                                  SizedBox(height: 16),
                                  _buildPetRecords(),
                                  SizedBox(height: 16),
                                  _buildForm(),
                                  SizedBox(height: 16),
                                  _buildHelpDesk(),
                                  SizedBox(height: 16),
                                  Text(
                                    'Topics you might like',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  loadingTopicsData
                                      ? LoadingIndicator()
                                      : _buildTopics(),
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
            ),
          );
        },
      ),
    );
  }

  List helpDeskList = [
    {
      'title': 'What do i need to buy for Arya?',
      'description': 'High quality puppy,food and water',
    },
    {
      'title': 'What do i need to buy for Arya?',
      'description': 'High quality puppy,food and water',
    },
    {
      'title': 'What do i need to buy for Arya?',
      'description': 'High quality puppy,food and water',
    },
    {
      'title': 'What do i need to buy for Arya?',
      'description': 'High quality puppy,food and water',
    },
    {
      'title': 'What do i need to buy for Arya?',
      'description': 'High quality puppy,food and water',
    },
  ];
  _buildHelpDesk() {
    return Container(
      // height: displayHeight(context) * 0.08,
      width: double.infinity,
      decoration: kBox5Decoration(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: helpDeskList.length,
          itemBuilder: (BuildContext context, int index) {
            return ExpansionTile(
              childrenPadding: EdgeInsets.symmetric(horizontal: 0),
              tilePadding: EdgeInsets.symmetric(horizontal: 8),
              title: Text(helpDeskList[index]['title'], style: kHeading14),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  autofocus: false,
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  title: Text(
                    helpDeskList[index]['description'],
                    style: kHeading14,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  _buildNotesDialog() {
    return SimpleDialog(
      backgroundColor: Color(0xFFFFFBA3),
      elevation: 2,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Container(
            child: Column(
              children: [
                Align(
                  heightFactor: 0.8,
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => _notesController.clear(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.delete,
                          size: 17,
                        ),
                        Text(
                          'Clear',
                          style: kHeading14,
                        )
                      ],
                    ),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none, fillColor: Colors.yellow),
                  minLines: 8,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _notesController,
                ),
                Container(
                  // height: 10,
                  child: Row(
                    children: [
                      Spacer(),
                      InkWell(
                        child: Text(
                          'Save and Return',
                          style: kHeading14.copyWith(
                              fontWeight: FontWeight.w600, color: Colors.black),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildTopics() {
    return Flexible(
        flex: 0,
        child: SizedBox(
          height: displayHeight(context) * 0.22,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: _topicsData.topics.length,
            itemBuilder: (context, index) {
              return TopicsList(
                infoText: _topicsData.topics[index].title,
                infoImage: _topicsData.topics[index].thumbnail,
                // press: () {
                //   _navigateToInfoDetail(
                //       "Food Insights",
                //       insights.foodsInsights[index]
                //           .info);
                // },
              );
            },
          ),
        ));
  }

  _buildForm() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        // width: double.infinity,
        width: displayWidth(context) - 32,
        color: kCustomYellowColor,
        // decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Take a assesment to \nsee how arya is doing',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white,
                    // fontWeight: FontWeight.w500,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  //borderSide: BorderSide(width: 1.0, color: Colors.white),
                  child: Text(
                    'Fill Form',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white,
                      // fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildAds() {
    return Container(
      margin: EdgeInsets.zero,
      child: Image.asset(
        "assets/images/homepage_image.png",
        width: displayWidth(context) - 32,
        // width: double.infinity,
      ),
      // color: Colors.blue,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
      ),
    );
  }

  _buildPetRecords() {
    String statusVaccinationAndDeworming,
        statusMeasurement,
        statusPicture,
        nameVaccinationAndDeworming,
        nameMeasurement,
        namePicture,
        daysVaccinationAndDewroming,
        daysMeasurement,
        daysPicture;
    if (!loadingPetRecordsAndNotes) {
      print(loadingPetRecordsAndNotes);
      if (UserData.user.petRecordsAndNotes.vaccinations.pendingVaccination !=
              null &&
          UserData.user.petRecordsAndNotes.vaccinations.pendingVaccination
                  .length !=
              0) {
        print(UserData.user.petRecordsAndNotes.vaccinations.pendingVaccination);
        statusVaccinationAndDeworming = "Pending";
        // Verify the assumed order
        Vaccination pendingVaccination =
            UserData.user.petRecordsAndNotes.vaccinations.pendingVaccination[0];
        nameVaccinationAndDeworming = pendingVaccination.name;
        daysVaccinationAndDewroming =
            ((pendingVaccination.date.millisecondsSinceEpoch -
                            DateTime.now().millisecondsSinceEpoch) /
                        1000 /
                        60 /
                        60 /
                        24)
                    .toInt()
                    .toString() +
                " days";
      } else if (UserData.user.petRecordsAndNotes.dewormings.pendingDeworming !=
              null &&
          UserData.user.petRecordsAndNotes.dewormings.pendingDeworming.length >
              0) {
        statusVaccinationAndDeworming = "Pending";

        Deworming pendingDeworming =
            UserData.user.petRecordsAndNotes.dewormings.pendingDeworming[0];
        nameVaccinationAndDeworming = "Deworming";
        daysVaccinationAndDewroming = "(" +
            ((pendingDeworming.date.millisecondsSinceEpoch -
                        DateTime.now().millisecondsSinceEpoch) /
                    1000 /
                    60 /
                    60 /
                    24)
                .toString() +
            " days)";
      } else {
        if (UserData.user.petRecordsAndNotes.vaccinations
                    .completedVaccination ==
                null ||
            UserData.user.petRecordsAndNotes.vaccinations.completedVaccination
                    .length ==
                0) {
          statusVaccinationAndDeworming = "------";

          nameVaccinationAndDeworming = "No Records Found";
          daysVaccinationAndDewroming = "";
        } else {
          statusVaccinationAndDeworming = "Last Known";

          Vaccination completedVaccination = UserData
              .user.petRecordsAndNotes.vaccinations.completedVaccination[0];
          nameVaccinationAndDeworming = completedVaccination.name;
          daysVaccinationAndDewroming = "(" +
              ((DateTime.now().millisecondsSinceEpoch -
                          completedVaccination.date.millisecondsSinceEpoch) /
                      1000 /
                      60 /
                      60 /
                      24)
                  .toString() +
              " days)";
        }
      }

      // if(UserData
      //         .user.petRecordsAndNotes.measurements
      //     0)
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: loadingPetRecordsAndNotes
          ? LoadingIndicator()
          : Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        BlocProvider.of<HomeBloc>(context).add(
                            VaccinationDataLoadedEvent(
                                UserData.user.petRecordsAndNotes));

                        return BlocProvider.value(
                            value: BlocProvider.of<HomeBloc>(context),
                            child: VaccinationpPage());
                      }));
                    },
                    child: _buildPetRecords1(
                        'Clinical Care',
                        "assets/images/vaccination_icon.svg",
                        Colors.red,
                        // "pending",
                        // "44",
                        // name: "parvo",
                        statusVaccinationAndDeworming,
                        days: daysVaccinationAndDewroming,
                        name: nameVaccinationAndDeworming),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        BlocProvider.of<HomeBloc>(context).add(
                            VaccinationDataLoadedEvent(
                                UserData.user.petRecordsAndNotes));

                        return BlocProvider.value(
                            value: BlocProvider.of<HomeBloc>(context),
                            child: MeasurementPage());
                      }));
                    },
                    child: _buildPetRecords1(
                        "Measurement",
                        "assets/images/measurement_icon.svg",
                        Colors.green,
                        "Pending",
                        days: "(5 days)",
                        name: "Parvo"),
                  ),
                  InkWell(
                    onTap: () {
                      ApiRepository().getAPetWithId();
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        BlocProvider.of<HomeBloc>(context).add(
                            PictureDataLoadedEvent(
                                petRecordsAndNotes:
                                    UserData.user.petRecordsAndNotes));

                        return BlocProvider.value(
                            value: BlocProvider.of<HomeBloc>(context),
                            child: UpdateProfilePage());
                      }));
                    },
                    child: _buildPetRecords1(
                        'Pictures', null, Colors.green, "Pending",
                        days: "(5 days)", name: "Parvo", userImage: userImage),
                  ),
                ],
              ),
            ),
    );
  }

  _buildPetRecords1(String title, String svg, Color color, String statusKey,
      {String days, String name, String userImage}) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? '',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                svg != null
                    ? CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: SvgPicture.asset(
                          "assets/images/vaccination_ellipse.svg",
                          color: color,
                        ),
                      )
                    : Container(),
                svg != null
                    ? SvgPicture.asset(svg)
                    : loadingPetRecordsAndNotes
                        ? Container(
                            color: Colors.grey,
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(userImage),
                            radius: 25,
                          ),
              ],
            ),
          ),
          Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                statusKey,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  // color: Colors.white,
                ),
              ),
              Text(
                (name != "") ? name : '',
                style: GoogleFonts.poppins(
                    fontSize: 13, fontWeight: FontWeight.w400, color: color),
              ),
              Text(
                (days != "") ? days : '',
                style: GoogleFonts.poppins(
                    fontSize: 13, fontWeight: FontWeight.w400, color: color),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
