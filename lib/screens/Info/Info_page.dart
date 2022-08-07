import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/common/widgets/loading_indicator.dart';
import 'package:pet_perfect_app/repositories/api_repository.dart';
import 'package:pet_perfect_app/screens/Info/bloc/info_bloc.dart';
import 'package:pet_perfect_app/screens/Info/info_view_all_page.dart';
import 'package:pet_perfect_app/screens/Info/models/insights.dart';
import 'package:pet_perfect_app/screens/components/side_bar.dart';
import 'package:pet_perfect_app/screens/Info/components/info_lists.dart';
import 'package:pet_perfect_app/screens/Info/info_detail.dart';
import 'package:pet_perfect_app/screens/components/default_search_box.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key key}) : super(key: key);
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  bool loadingData = true;
  Insights insights;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    // print(_scrollController.position.extentAfter);

    // if (_scrollController.position.pixels== _scrollController.position.maxScrollExtent *0.9) {
    if (_scrollController.position.extentAfter == 0) {
      print("list ended");
      final list = ApiRepository().getInsightsLists().then((value) {
        value.lifestyleInsights.forEach((element) {
          insights.lifestyleInsights.add(element);
        });
        // items.addAll(new List.generate(42, (index) => 'Inserted $index'));
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InsightsBloc, InsightsState>(
      listener: (context, state) {
        if (state is InsightsPageLoadingState) {
          loadingData = true;
        }
        if (state is InsightsPageLoadedState) {
          insights = state.insights;
          loadingData = false;
        }
      },
      child: BlocBuilder<InsightsBloc, InsightsState>(
        builder: (context, state) {
          return Scaffold(
            drawer: SideBar(),
            appBar: AppBar(
              title:Text(
                    "Pet Sastra",
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
                children: [
                  Container(
                    height: displayHeight(context) * 0.1,
                    // alignment: Alignment.center,
                    width: double.infinity,
                    color: kPrimaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DefaultSearchBox(
                            hintText: 'Search Info',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      // height: displayHeight(context),
                      width: double.infinity,
                      decoration: kBackgroundBoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(height: 16),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                "Pet Sastra",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                "Personalized informations for Arya",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () => onParticularServiceTypeTapped(
                                        "Food Insights",
                                        insights.foodsInsights),
                                    child: Text(
                                      "Food Insights",
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => onParticularServiceTypeTapped(
                                        "Food Insights",
                                        insights.foodsInsights),
                                    child: Text(
                                      'View all',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: displayHeight(context) * 0.01),
                            loadingData
                                ? SizedBox(
                                    height: displayHeight(context) * 0.22,
                                    child: LoadingIndicator())
                                : Flexible(
                                    flex: 0,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: SizedBox(
                                        height: displayHeight(context) * 0.22,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              insights.foodsInsights.length,
                                          itemBuilder: (context, index) {
                                            return InfoLists(
                                              infoText: insights
                                                  .foodsInsights[index].title,
                                              infoImage: insights
                                                  .foodsInsights[index]
                                                  .thumbnail,
                                              press: () {
                                                _navigateToInfoDetail(
                                                    "Food Insights",
                                                    insights
                                                        .foodsInsights[index]
                                                        .info,
                                                        
                                                        insights.foodsInsights[index].title
                                                        );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    )),
                            SizedBox(height: 16),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () => onParticularServiceTypeTapped(
                                        "Lifestyle Insights",
                                        insights.lifestyleInsights),
                                    child: Text(
                                      "Lifestyle Insights",
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => onParticularServiceTypeTapped(
                                        "Lifestyle Insights",
                                        insights.lifestyleInsights),
                                    child: InkWell(
                                      onTap: () =>
                                          onParticularServiceTypeTapped(
                                              "Lifestyle Insights",
                                              insights.lifestyleInsights),
                                      child: Text(
                                        "View all",
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: displayHeight(context) * 0.01),
                            loadingData
                                ? SizedBox(
                                    height: displayHeight(context) * 0.22,
                                    child: LoadingIndicator())
                                : Flexible(
                                    flex: 0,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: SizedBox(
                                        height: displayHeight(context) * 0.22,
                                        child: ListView.builder(
                                          controller: _scrollController,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              insights.lifestyleInsights.length,
                                          itemBuilder: (context, index) {
                                            return InfoLists(
                                              infoText: insights
                                                  .lifestyleInsights[index]
                                                  .title,
                                              infoImage: insights
                                                  .lifestyleInsights[index]
                                                  .thumbnail,
                                              press: () {
                                                _navigateToInfoDetail(
                                                    "Lifestyle Insights",
                                                    insights
                                                        .lifestyleInsights[
                                                            index]
                                                        .info,
                                                        
                                                        insights.lifestyleInsights[index].title
                                                        );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    )),
                            SizedBox(height: displayHeight(context) * 0.025),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () => onParticularServiceTypeTapped(
                                        "Health Insights",
                                        insights.healthInsights),
                                    child: Text(
                                      "Health Insights",
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => onParticularServiceTypeTapped(
                                        "Health Insights",
                                        insights.healthInsights),
                                    child: Text(
                                      "View all",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: displayHeight(context) * 0.01),
                            loadingData
                                ? SizedBox(
                                    height: displayHeight(context) * 0.22,
                                    child: LoadingIndicator())
                                : Flexible(
                                    flex: 0,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: SizedBox(
                                        height: displayHeight(context) * 0.22,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              insights.healthInsights.length,
                                          itemBuilder: (context, index) {
                                            return InfoLists(
                                              infoText: insights
                                                  .healthInsights[index].title,
                                              infoImage: insights
                                                  .healthInsights[index]
                                                  .thumbnail,
                                              press: () {
                                                _navigateToInfoDetail(
                                                    "Health Insights",
                                                    insights
                                                        .healthInsights[index]
                                                        .info,
                                                        insights.healthInsights[index].title
                                                        );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    )),
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

  // _buildPagination() {
  //   PaginatedListWidget(
  //     progressWidget: Center(
  //       child: LoadingIndicator(),
  //     ),
  //     itemListCallback: OnScrollCallback(),
  //   );
  // }

  void _navigateToInfoDetail(
      String insightsType, List<Map<String, String>> info,String title) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<InsightsBloc>(context),
                  child: InfoDetail(
                    insightsType: insightsType,
                    info: info,
                    title: title,
                  ),
                )));
  }

  onParticularServiceTypeTapped(String insightsType, List insightsList) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: BlocProvider.of<InsightsBloc>(context)
                  ..add(ParticularInsightsViewAllPageInitializedEvent(
                      insightsType: insightsType, insightsList: insightsList)),
                child: InfoViewAllPage(
                  insightsType: insightsType,
                ))));
  }
}
