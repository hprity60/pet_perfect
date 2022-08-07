// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pet_perfect_app/common/widgets/loading_indicator.dart';
// import 'package:pet_perfect_app/services/bloc/services_bloc.dart';
// import 'package:pet_perfect_app/services/components/service_short_card.dart';
// import 'package:pet_perfect_app/services/models/services.dart';
// import 'package:pet_perfect_app/services/view/particular_service_view_all_page.dart';
// import 'package:pet_perfect_app/screens/components/side_bar.dart';
// import 'package:pet_perfect_app/services/view/service_detail.dart';
// import 'package:pet_perfect_app/utils/color_helpers.dart';
// import 'package:pet_perfect_app/utils/size_helpers.dart';
// import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
// import 'package:pet_perfect_app/utils/font_style_helpers.dart';
// import 'package:pet_perfect_app/screens/components/default_search_box.dart';

// class ServicesPage extends StatefulWidget {
//   const ServicesPage({Key key}) : super(key: key);
//   @override
//   _ServicesPageState createState() => _ServicesPageState();
// }

// class _ServicesPageState extends State<ServicesPage> {
//   bool showLoading;
//   Services services;
//   var data = ['All', 'Vets', 'Groomers', 'Boarders', 'Trainers'];
//   int _value = 1;

//   String _serviceType = '';

//   @override
//   _ServicesPageState() {
//     showLoading = true;
//   }

//   onParticularServiceTypeTapped(String serviceType) {
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (_) => BlocProvider.value(
//                 value: BlocProvider.of<ServicesBloc>(context)
//                   ..add(ParticularServiceViewAllPageInitializedEvent(
//                       serviceType: serviceType)),
//                 child: ParticularServiceViewAll())));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ServicesBloc, ServicesState>(
//       listener: (context, state) {
//         if (state is ServicesPageServicesLoadingState ||
//             state is ServicesInitialState) showLoading = true;
//         if (state is ServicesPageServicesLoadedState) {
//           showLoading = false;
//           services = state.services;
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           drawer: SideBar(),
//           appBar: AppBar(
//             title: Text(
//               "Pet Perfect",
//               style: GoogleFonts.poppins(color: Colors.white),
//             ),
//             elevation: 0,
//             backgroundColor: kPrimaryColor,
//             actions: [
//               IconButton(
//                 icon: Image.asset(
//                   'assets/images/notification.png',
//                   color: kWhiteBackgroundColor,
//                 ),
//                 onPressed: () {},
//               ),
//             ],
//           ),
//           backgroundColor: kPrimaryColor,
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   height: displayHeight(context) * 0.1,
//                   width: double.infinity,
//                   color: kPrimaryColor,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         DefaultSearchBox(
//                           hintText: 'Search for service',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SingleChildScrollView(
//                   child: Container(
//                     width: double.infinity,
//                     decoration: kBackgroundBoxDecoration(),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 16),
//                         Row(
//                           children: [
//                             SizedBox(width: displayWidth(context) * 0.06),
//                             Text(
//                               "Pet Services",
//                               style: kHeading20,
//                               textAlign: TextAlign.left,
//                             ),
//                           ],
//                         ),
//                         // SizedBox(height: displayHeight(context) * 0.02),

//                         SingleChildScrollView(
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 16),
//                             child: Container(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       InkWell(
//                                         onTap: () =>

//                                             onParticularServiceTypeTapped(
//                                                 "vets"),
//                                         child: Text('  Vets',
//                                             style: kHeading18.copyWith(
//                                                 fontWeight: FontWeight.w600)),
//                                       ),
//                                       InkWell(
//                                         onTap: () =>
//                                             onParticularServiceTypeTapped(
//                                                 "vets"),
//                                         child: Text(
//                                           'View all',
//                                           style: kHeading16,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                       height: displayHeight(context) * 0.01),
//                                   showLoading
//                                       ? SizedBox(
//                                           height: displayHeight(context) * 0.22,
//                                           child: LoadingIndicator())
//                                       : Flexible(
//                                           flex: 0,
//                                           child: SizedBox(
//                                             height:
//                                                 displayHeight(context) * 0.24,
//                                             child: ListView.builder(
//                                                 shrinkWrap: true,
//                                                 scrollDirection:
//                                                     Axis.horizontal,
//                                                 itemCount: services.vets.length,
//                                                 itemBuilder: (context, index) {
//                                                   return ServiceShortCard(
//                                                       press: () {
//                                                         Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                                 builder: (context) => ServiceDetail(
//                                                                     serviceType:
//                                                                         'Vets',
//                                                                     service: services
//                                                                             .vets[
//                                                                         index])));
//                                                       },
//                                                       // image: services
//                                                       //     .vets[index]
//                                                       //     .images[0],
//                                                       image: services
//                                                           .vets[index]
//                                                           .thumbnail,
//                                                       name: services
//                                                           .vets[index].name,
//                                                       rating:
//                                                           '${services.vets[index].rating}',
//                                                       distance:
//                                                           '${services.vets[index].distance}');
//                                                 }),
//                                           ),
//                                         ),
//                                   // SizedBox(height: displayHeight(context) * 0.025),

//                                   // SizedBox(height: 16),
//                                   // Row(
//                                   //   mainAxisAlignment:
//                                   //       MainAxisAlignment.spaceBetween,
//                                   //   children: [
//                                   //     InkWell(
//                                   //       onTap: () =>
//                                   //           onParticularServiceTypeTapped(
//                                   //               "groomers"),
//                                   //       child: Text('  Groomers',
//                                   //           style: kHeading18.copyWith(
//                                   //               fontWeight: FontWeight.w600)),
//                                   //     ),
//                                   //     InkWell(
//                                   //       onTap: () =>
//                                   //           onParticularServiceTypeTapped(
//                                   //               "groomers"),
//                                   //       child: Text(
//                                   //         'View all',
//                                   //         style: kHeading16,
//                                   //       ),
//                                   //     ),
//                                   //   ],
//                                   // ),
//                                   // SizedBox(
//                                   //     height: displayHeight(context) * 0.01),
//                                   // showLoading
//                                   //     ? SizedBox(
//                                   //         height: displayHeight(context) * 0.22,
//                                   //         child: LoadingIndicator())
//                                   //     : SizedBox(
//                                   //         height: displayHeight(context) * 0.24,
//                                   //         child: ListView.builder(
//                                   //             shrinkWrap: true,
//                                   //             scrollDirection: Axis.horizontal,
//                                   //             itemCount:
//                                   //                 services.groomers.length,
//                                   //             itemBuilder: (context, index) {
//                                   //               return ServiceShortCard(
//                                   //                   press: () {
//                                   //                     Navigator.push(
//                                   //                         context,
//                                   //                         MaterialPageRoute(
//                                   //                             builder: (context) => ServiceDetail(
//                                   //                                 serviceType:
//                                   //                                     'Groomers',
//                                   //                                 service: services
//                                   //                                         .vets[
//                                   //                                     index])));
//                                   //                   },
//                                   //                   // image: services
//                                   //                   //     .groomers[index]
//                                   //                   //     .images[0],
//                                   //                   image: services
//                                   //                       .groomers[index]
//                                   //                       .thumbnail,
//                                   //                   name: services
//                                   //                       .groomers[index].name,
//                                   //                   rating:
//                                   //                       '${services.groomers[index].rating}',
//                                   //                   distance:
//                                   //                       '${services.vets[index].distance}');
//                                   //             }),
//                                   //       ),
//                                   // // SizedBox(
//                                   // //     height: displayHeight(context) * 0.025),
//                                   // SizedBox(height: 16),
//                                   // Row(
//                                   //   mainAxisAlignment:
//                                   //       MainAxisAlignment.spaceBetween,
//                                   //   children: [
//                                   //     InkWell(
//                                   //       onTap: () =>
//                                   //           onParticularServiceTypeTapped(
//                                   //               "boarders"),
//                                   //       child: Text(
//                                   //         '  Boarders',
//                                   //         style: kHeading18.copyWith(
//                                   //             fontWeight: FontWeight.w600),
//                                   //       ),
//                                   //     ),
//                                   //     InkWell(
//                                   //       onTap: () =>
//                                   //           onParticularServiceTypeTapped(
//                                   //               "boarders"),
//                                   //       child: Text(
//                                   //         'View all',
//                                   //         style: kHeading16,
//                                   //       ),
//                                   //     ),
//                                   //   ],
//                                   // ),
//                                   // SizedBox(
//                                   //     height: displayHeight(context) * 0.01),
//                                   // showLoading
//                                   //     ? SizedBox(
//                                   //         height: displayHeight(context) * 0.22,
//                                   //         child: LoadingIndicator())
//                                   //     : SizedBox(
//                                   //         height: displayHeight(context) * 0.24,
//                                   //         child: ListView.builder(
//                                   //             shrinkWrap: true,
//                                   //             scrollDirection: Axis.horizontal,
//                                   //             itemCount:
//                                   //                 services.boarders.length,
//                                   //             itemBuilder: (context, index) {
//                                   //               return ServiceShortCard(
//                                   //                   press: () {
//                                   //                     Navigator.push(
//                                   //                         context,
//                                   //                         MaterialPageRoute(
//                                   //                             builder: (context) => ServiceDetail(
//                                   //                                 serviceType:
//                                   //                                     'Boarders',
//                                   //                                 service: services
//                                   //                                         .vets[
//                                   //                                     index])));
//                                   //                   },
//                                   //                   // image: services
//                                   //                   //     .boarders[index]
//                                   //                   //     .images[0],

//                                   //                   image: services
//                                   //                       .boarders[index]
//                                   //                       .thumbnail,
//                                   //                   name: services
//                                   //                       .boarders[index].name,
//                                   //                   rating:
//                                   //                       '${services.boarders[index].rating}',
//                                   //                   distance:
//                                   //                       '${services.vets[index].distance}');
//                                   //             }),
//                                   //       ),

//                                   // SizedBox(height: 16),
//                                   // Row(
//                                   //   mainAxisAlignment:
//                                   //       MainAxisAlignment.spaceBetween,
//                                   //   children: [
//                                   //     InkWell(
//                                   //         onTap: () =>
//                                   //             onParticularServiceTypeTapped(
//                                   //                 "trainers"),
//                                   //         child: Text(
//                                   //           '  Trainers',
//                                   //           style: kHeading20.copyWith(
//                                   //               fontWeight: FontWeight.w600),
//                                   //         )),
//                                   //     InkWell(
//                                   //       onTap: () =>
//                                   //           onParticularServiceTypeTapped(
//                                   //               "trainers"),
//                                   //       child: Text(
//                                   //         'View all',
//                                   //         style: kHeading16,
//                                   //       ),
//                                   //     ),
//                                   //   ],
//                                   // ),
//                                   // SizedBox(
//                                   //     height: displayHeight(context) * 0.01),
//                                   // showLoading
//                                   //     ? SizedBox(
//                                   //         height: displayHeight(context) * 0.22,
//                                   //         child: LoadingIndicator())
//                                   //     : SizedBox(
//                                   //         height: displayHeight(context) * 0.24,
//                                   //         child: ListView.builder(
//                                   //             shrinkWrap: true,
//                                   //             scrollDirection: Axis.horizontal,
//                                   //             itemCount:
//                                   //                 services.trainers.length,
//                                   //             itemBuilder: (context, index) {
//                                   //               return ServiceShortCard(
//                                   //                   press: () {
//                                   //                     Navigator.push(
//                                   //                         context,
//                                   //                         MaterialPageRoute(
//                                   //                             builder: (context) => ServiceDetail(
//                                   //                                 serviceType:
//                                   //                                     'Trainers',
//                                   //                                 service: services
//                                   //                                         .vets[
//                                   //                                     index])));
//                                   //                   },
//                                   //                   // image: services
//                                   //                   //     .trainers[index]
//                                   //                   //     .images[0],

//                                   //                   image: services
//                                   //                       .trainers[index]
//                                   //                       .thumbnail,
//                                   //                   name: services
//                                   //                       .trainers[index].name,
//                                   //                   rating:
//                                   //                       '${services.trainers[index].rating}',
//                                   //                   distance:
//                                   //                       '${services.vets[index].distance}');
//                                   //             }),
//                                   //       ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
