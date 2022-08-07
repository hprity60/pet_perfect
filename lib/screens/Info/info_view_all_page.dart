import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/common/widgets/loading_indicator.dart';
import 'package:pet_perfect_app/screens/Info/bloc/info_bloc.dart';
import 'package:pet_perfect_app/screens/Info/components/info_lists.dart';
import 'package:pet_perfect_app/screens/Info/components/view_all_info_lists.dart';
import 'package:pet_perfect_app/screens/Info/info_detail.dart';
import 'package:pet_perfect_app/screens/components/side_bar.dart';
import 'package:pet_perfect_app/screens/Info/models/insight.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';

class InfoViewAllPage extends StatefulWidget {
  final String insightsType;
  final List insightsList;

  const InfoViewAllPage({this.insightsType,this.insightsList});
  @override
  _InfoViewAllPageState createState() => _InfoViewAllPageState();
}

class _InfoViewAllPageState extends State<InfoViewAllPage> {
  bool showLoading = true;
  List<Insight> insights;

  void _navigateToInfoDetail(
      String insightsType, List<Map<String, String>> info) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<InsightsBloc>(context),
                  child: InfoDetail(
                    insightsType: insightsType,
                    info: info,
                  ),
                )));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InsightsBloc, InsightsState>(
      listener: (context, state) {
        if (state is ParticularInsightViewAllLoadingState) showLoading = true;
        if (state is ParticularInsightViewAllLoadedState) {
          showLoading = false;
          insights = state.insights;
        }
      },
      builder: (context, state) {
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
                Container(
                  height: 70,
                  width: double.infinity,
                  color: kPrimaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.circular(33),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              hintText: 'Search nearby',
                              focusColor: Colors.black,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        Image.asset('assets/images/filter.png'),
                        Image.asset('assets/images/sort.png'),
                      ],
                    ),
                  ),
                ),
                // SingleChildScrollView(
                //   child: 
                  Container(
                    width: displayWidth(context),
                    decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(23),
                        topRight: Radius.circular(23),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            "Pet Services  >  ${widget.insightsType.toUpperCase()}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 20),
                          showLoading
                              ? LoadingIndicator()
                              : Flexible(
                                  flex: 0,
                                  child: SizedBox(
                                    height: displayHeight(context) * 0.75,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: insights.length,
                                          itemBuilder: (context, index) {
                                            return ViewAllInfoLists(
                                              infoText: insights[index].title,
                                              infoImage: insights[index].imageUrl,
                                              press: () {
                                                _navigateToInfoDetail(
                                                    "Food Insights",
                                                    insights[index].info);
                                              },
                                            );
                                          }),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
