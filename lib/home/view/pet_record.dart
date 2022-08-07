// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pet_perfect_app/common/models/user_data.dart';
// import 'package:pet_perfect_app/home/export.dart';
// import 'package:pet_perfect_app/profile/update_profile_page.dart';
// import 'package:pet_perfect_app/screens/components/record_lists.dart';

// import 'package:pet_perfect_app/home/bloc/home_bloc.dart';
// import 'package:pet_perfect_app/home/bloc/home_event.dart';
// import 'package:pet_perfect_app/home/bloc/home_state.dart';
// import 'package:pet_perfect_app/home/view/measurement.dart';
// import 'package:pet_perfect_app/home/view/vaccination_page.dart';

// import 'package:pet_perfect_app/utils/color_helpers.dart';
// import 'package:pet_perfect_app/utils/size_helpers.dart';

// class PetList extends StatefulWidget {
//   @override
//   _PetListState createState() => _PetListState();
// }

// class _PetListState extends State<PetList> {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   PetRecordsAndNotes petRecordsAndNotes = UserData.user.getPetRecordsAndNotes();
//   // bool loadingPetRecordsAndNotes = true;

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<HomeBloc, HomeState>(
//       listener: (context, state) {
//         if (state is PetRecordsAndNotesLoadingState) {
//           // loadingPetRecordsAndNotes = true;
//         }
//         if (state is PetRecordsAndNotesLoadedState) {
//           // loadingPetRecordsAndNotes = false;
//           // petRecordsAndNotes = User.petRecordsAndNotes;
//         }
//         if (state is DataFailureState) {
//           _scaffoldKey.currentState.showSnackBar(SnackBar(
//             content: Text(state.error),
//             backgroundColor: Colors.red,
//           ));
//         }
//       },
//       child: BlocBuilder<HomeBloc, HomeState>(
//         builder: (context, state) {
//           return Scaffold(
//             // drawer: SideBar(),
//             appBar: AppBar(
//               title: Text(
//                 "Pet Records",
//                 style: GoogleFonts.poppins(color: Colors.white),
//               ),
//               elevation: 0,
//               backgroundColor: kPrimaryColor,
//             ),
//             backgroundColor: kPrimaryColor,
//             body: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SingleChildScrollView(
//                     child: Container(
//                       /// do not need this height, also causes bottom overflow error
//                       // height: displayHeight(context) * 0.89,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         color: kSecondaryColor,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(23),
//                           topRight: Radius.circular(23),
//                         ),
//                       ),
//                       child: Column(
//                         children: [
//                           SingleChildScrollView(
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               child: Container(
//                                 height: displayHeight(context) * 10,
//                                 width: displayWidth(context) * 99,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(23),
//                                     topRight: Radius.circular(23),
//                                   ),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 10),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       SizedBox(height: 20),
//                                       // loadingPetRecordsAndNotes
//                                       // ? LoadingIndicator()
//                                       // :
//                                       Column(
//                                         children: [
//                                           RecordLists(
//                                             title: 'Picture',
//                                             press: () {
//                                               Navigator.push(context,
//                                                   MaterialPageRoute(
//                                                       builder: (_) {
//                                                 BlocProvider.of<HomeBloc>(
//                                                         context)
//                                                     .add(PictureDataLoadedEvent(
//                                                         petRecordsAndNotes:
//                                                             petRecordsAndNotes));

//                                                 return BlocProvider.value(
//                                                     value: BlocProvider.of<
//                                                         HomeBloc>(context),
//                                                     child: UpdateProfilePage());
//                                               }));
//                                             },
//                                             date: petRecordsAndNotes
//                                                 .pictures[0].date
//                                                 .toString(),
//                                             // image: petRecordsAndNotes
//                                             //     .pictures[0].url,
//                                             image: 'assets/images/needle.png',
//                                           ),
//                                           SizedBox(height: 20),
//                                           RecordLists(
//                                             title: 'Vaccination & Deworming',
//                                             press: () {
//                                               Navigator.of(context).push(
//                                                   MaterialPageRoute(
//                                                       builder: (_) {
//                                                 // BlocProvider.of<HomeBloc>(context).add(
//                                                 //     VaccinationDataLoadedEvent());

//                                                 //need to return blocprovider
//                                                 return BlocProvider.value(
//                                                     value: BlocProvider.of<
//                                                         HomeBloc>(context),
//                                                     child: VaccinationpPage());
//                                               }));
//                                             },
//                                             date: petRecordsAndNotes
//                                                 .vaccinations[0].date,
//                                             image: 'assets/images/needle.png',
//                                           ),
//                                           SizedBox(height: 20),
//                                           RecordLists(
//                                             title: 'Measurements',
//                                             press: () {
//                                               Navigator.push(context,
//                                                   MaterialPageRoute(
//                                                       builder: (_) {
//                                                 // BlocProvider.of<HomeBloc>(
//                                                 //         context)
//                                                 //     .add(
//                                                 //         VaccinationDataLoadedEvent());

//                                                 return BlocProvider.value(
//                                                     value: BlocProvider.of<
//                                                         HomeBloc>(context),
//                                                     child: MeasurementPage());
//                                               }));
//                                             },
//                                             date: petRecordsAndNotes
//                                                 .vaccinations[0].date,
//                                             image: 'assets/images/weight.png',
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
