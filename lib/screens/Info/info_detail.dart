import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/screens/Info/bloc/info_bloc.dart';
import 'package:pet_perfect_app/screens/components/default_search_box.dart';
import 'package:pet_perfect_app/screens/Info/components/splash_content.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';

import 'components/info_lists.dart';

class InfoDetail extends StatefulWidget {
  final String insightsType;
  final String title;
  final List<Map<String, String>> info;
  InfoDetail({
    this.insightsType,
    this.title,
    this.info,
  });

  @override
  _InfoDetailState createState() => _InfoDetailState();
}

class _InfoDetailState extends State<InfoDetail> {
  int currentPage = 0;
  bool loadingData = true;
  bool isSwipedUp = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<InsightsBloc, InsightsState>(
      listener: (context, state) {
        // if (state is InsightsPageLoadingState || state is InsightsInitialState)
        //   loadingData = true;
        // if (state is InsightsPageLoadedState) {
        //   insights = state.insights;
        //   loadingData = false;
        // }
      },
      child:
          BlocBuilder<InsightsBloc, InsightsState>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.insightsType,
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
                    decoration: BoxDecoration(
                      // color: kSecondaryColor,
                      color: Color(0xFFF8F5F0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            child: Container(
                              height: fitToHeight(400, context),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      Color(0xFFFFF9F1),
                                      Color(0xFFEDD1B0)
                                    ]),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 24),
                                child: PageView.builder(
                                  onPageChanged: (value) {
                                    setState(() {
                                      currentPage = value;
                                    });
                                  },
                                  itemCount: widget.info.length,
                                  itemBuilder: (context, index) =>
                                      SplashContent(
                                    // text1: widget.info[index]['text1'],
                                    text1: widget.title,
                                    text2: widget.info[index]['text2'],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              widget.info.length,
                              (index) => builsDot(index: index),
                            ),
                          ),
                          Expanded(child: Container()),
                          GestureDetector(
                            onVerticalDragEnd: (drag) {
                              if (drag.primaryVelocity < 0) {
                                print("swipe up");
                                setState(() {
                                  isSwipedUp = true;
                                });
                              }
                              if (drag.primaryVelocity > 0) {
                                print("swipe down");
                                setState(() {
                                  isSwipedUp = false;
                                });
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    color: kSecondaryBackgroundColor,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: isSwipedUp
                                          ? Icon(Icons.arrow_downward_rounded)
                                          : Icon(Icons.arrow_upward_rounded),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          isSwipedUp ? _buildMoreList() : Container()
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  _buildMoreList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(
          "More Insights",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              InfoLists(
                press: () {},
                infoText: 'Making Safe Your Home and Garden for Arya',
                infoImage: 'assets/images/img3.png',
              ),
              SizedBox(width: 8),
              InfoLists(
                press: () {},
                infoText: 'Food Items to Avoid for Arya',
                infoImage: 'assets/images/img4.png',
              ),
              SizedBox(width: 8),
              InfoLists(
                press: () {},
                infoText: 'Making Safe Your Home and Garden for Arya',
                infoImage: 'assets/images/img3.png',
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  AnimatedContainer builsDot({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 15 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFC4C4C4),
        borderRadius: BorderRadius.circular(55),
      ),
    );
  }
}
