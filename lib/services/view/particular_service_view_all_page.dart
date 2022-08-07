import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/common/widgets/loading_indicator.dart';
import 'package:pet_perfect_app/screens/components/side_bar.dart';
import 'package:pet_perfect_app/services/bloc/services_bloc.dart';
import 'package:pet_perfect_app/services/models/service.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/services/view/service_detail.dart';
import 'package:pet_perfect_app/services/components/service_list_tile.dart';
import 'dart:ui';
import 'package:pet_perfect_app/screens/components/default_search_box.dart';

class ParticularServiceViewAll extends StatefulWidget {
  // final String serviceType;
  ParticularServiceViewAll({
    Key key,
  }) : super(key: key);

  @override
  _ParticularServiceViewAllState createState() =>
      _ParticularServiceViewAllState();
}

class _ParticularServiceViewAllState extends State<ParticularServiceViewAll> {
  @override
  void initState() {
    super.initState();

    print("init");
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print(_scrollController.position.pixels);
        print("Here here here");
        pageNumber++;
        setState(() {
          // showLoading = false;
        });
        if (search) {
          return BlocProvider.of<ServicesBloc>(context).add(SearchServiceEvent(
            searchText,
            serviceType,
            pageNumber: pageNumber,
          ));
        }

        BlocProvider.of<ServicesBloc>(context).add(
            ParticularServiceViewAllPageInitializedEvent(
                serviceType: serviceType,
                pageNumber: pageNumber,
                sortByRating: sortByRating));
      }
    });
  }

  bool showFirstLoading = true;
  bool sortByRating = false;
  List<Service> service;
  // Services services;
  ScrollController _scrollController = ScrollController();
  TextEditingController controller = TextEditingController();

  String serviceType = 'All';
  bool search = false;
  bool listFinished = false;
  String searchText;
  int pageNumber = 1;
  var data = ['All', 'Vets', 'Groomers', 'Boarders', 'Trainers'];
  int _value = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServicesBloc, ServicesState>(
      listener: (context, state) {
        if (state is ParticularServiceViewAllLoadingState) {
          showFirstLoading = true;
        }
        if (state is ParticularServiceViewAllLoadedState) {
          showFirstLoading = false;

          // showLoading = false;
          service = state.service;
          listFinished = state.listFinished;
        }
        if (state is ServicesInitialState) {
          showFirstLoading = true;
        }
        if (state is PaginationLoadingState) {
          showFirstLoading = false;
        }

        if (state is ServicesPageServicesLoadingState) {
          showFirstLoading = true;
        }
        // if (state is ServicesPageServicesLoadedState) {
        //   showLoading = false;
        //   services = state.services;
        //   service = state.services.vets;
        // }
      },
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
          backgroundColor: kCustomWhiteColor,
          body: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Container(
                  height: displayHeight(context) * 0.1,
                  width: double.infinity,
                  color: kPrimaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DefaultSearchBox(
                          controller: controller,
                          hintText: 'Search for service',
                          onCross: () {
                            print('cross');
                            setState(() {
                              controller.text = "";
                              controller.clear();
                              searchText = "";
                            });
                            pageNumber = 1;
                            search = false;
                            BlocProvider.of<ServicesBloc>(context).add(
                                ParticularServiceViewAllPageInitializedEvent(
                                    serviceType: serviceType,
                                    pageNumber: pageNumber,
                                    sortByRating: sortByRating));
                          },
                          onEnter: (String text) {
                            searchText = text;
                            print(searchText);

                            if (text == null || text == "") {
                              pageNumber = 1;
                              search = false;
                              return;
                            }
                            pageNumber = 1;
                            search = true;
                            BlocProvider.of<ServicesBloc>(context)
                                .add(SearchServiceEvent(
                              text,
                              serviceType,
                              pageNumber: pageNumber,
                            ));
                          },
                        ),
                        // IconButton(
                        //   icon: Icon(Icons.close),
                        //   onPressed: () {
                        //     print("ALoooahdaspd");

                        //     setState(() {
                        //       controller.clear();
                        //     });
                        //     setState(() {
                        //       controller.text = "";
                        //       searchText = "";
                        //     });
                        //     pageNumber = 1;
                        //     search = false;
                        //     BlocProvider.of<ServicesBloc>(context).add(
                        //         ParticularServiceViewAllPageInitializedEvent(
                        //             serviceType: serviceType,
                        //             pageNumber: pageNumber,
                        //             sortByRating: sortByRating));
                        //     print(controller.text);
                        //   },
                        // ),
                        search
                            ? SizedBox()
                            : PopupMenuButton<String>(
                                onSelected: (index) {
                                  print(index);
                                  if (index == "1") {
                                    pageNumber = 1;
                                    sortByRating = false;
                                    print("Hello");
                                    BlocProvider.of<ServicesBloc>(context).add(
                                        ParticularServiceViewAllPageInitializedEvent(
                                            serviceType: serviceType,
                                            pageNumber: pageNumber,
                                            sortByRating: sortByRating));
                                  } else {
                                    pageNumber = 1;
                                    sortByRating = true;
                                    BlocProvider.of<ServicesBloc>(context).add(
                                        ParticularServiceViewAllPageInitializedEvent(
                                            serviceType: serviceType,
                                            pageNumber: pageNumber,
                                            sortByRating: sortByRating));
                                  }
                                },
                                child: Icon(
                                  Icons.filter_list,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      value: "1",
                                      child: Text('By Location'),
                                    ),
                                    PopupMenuItem(
                                      value: "2",
                                      child: Text('By Rating'),
                                    )
                                  ];
                                },
                              )
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  // controller: _scrollController,
                  child: Container(
                    width: displayWidth(context),
                    decoration: kBackgroundBoxDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(height: 16),
                          Container(
                            child: Text(
                              "Pet Services",
                              style: kHeading20,
                            ),
                          ),
                          SizedBox(height: 16),
                          _buildChip(),
                          SizedBox(height: 16),
                          showFirstLoading
                              ? LoadingIndicator()
                              : Flexible(
                                  flex: 0,
                                  child: SizedBox(
                                    // height: displayHeight(context) * 0.75,
                                    child: ListView.builder(
                                        // controller: _scrollController,
                                        shrinkWrap: true,
                                        itemCount: listFinished
                                            ? service.length
                                            : service.length + 1,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          if (index == service.length &&
                                              !listFinished) {
                                            return LoadingIndicator();
                                          }
                                          return ServiceListTile(
                                              press: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ServiceDetail(
                                                                serviceType:
                                                                    'Vet',
                                                                service: service[
                                                                    index])));
                                              },
                                              image: service[index].images[0],
                                              serviceProvider:
                                                  service[index].name,
                                              timings: service[index].timings,
                                              review: service[index]
                                                  .rating
                                                  .toString(),
                                              distance:
                                                  '${service[index].distance.toString().substring(0, 4)} km',
                                              phoneNumber:
                                                  service[index].phoneNumber,
                                              serviceType:
                                                  service[index].category);
                                        }),
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
    );
  }

  _buildChip() {
    return Container(
      height: 50,
      // color: Colors.blue,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              elevation: 1,
              label: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  data[index],
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              selected: _value == index,
              selectedColor: Colors.green,
              onSelected: (bool value) {
                if (index != _value) {
                  setState(() {
                    _value = value ? index : null;
                    // type = data[index];
                    serviceType = data[index];
                    if (search) {
                      return BlocProvider.of<ServicesBloc>(context)
                          .add(SearchServiceEvent(
                        searchText,
                        serviceType,
                        pageNumber: pageNumber,
                      ));
                    }
                    BlocProvider.of<ServicesBloc>(context).add(
                        ParticularServiceViewAllPageInitializedEvent(
                            sortByRating: sortByRating,
                            serviceType: data[index]));
                  });
                }
              },
              backgroundColor: Colors.white,
              labelStyle: TextStyle(color: Colors.black),
            ),
          );
        },
      ),
    );
  }
}

/* 

*/
