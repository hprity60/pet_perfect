import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/common/widgets/call_now.dart';
import 'package:pet_perfect_app/common/widgets/open_maps_for_direction_now%20copy.dart';
import 'package:pet_perfect_app/services/models/service.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/common/widgets/zoomImage.dart';

class ServiceDetail extends StatefulWidget {
  final Service service;
  final String serviceType;
  @override
  _ServiceDetailState createState() => _ServiceDetailState();
  ServiceDetail({this.service, this.serviceType});
}

class _ServiceDetailState extends State<ServiceDetail> {
  String getDayForNumber(int num) {
    switch (num) {
      case 0:
        return 'Mon';
      case 1:
        return 'Tue';
      case 2:
        return 'Wed';
      case 3:
        return 'Thu';
      case 4:
        return 'Fri';
      case 5:
        return 'Sat';
      case 6:
        return 'Sun';
    }
  }

  // formTimings() {
  //   // 1 - Mon
  //   // 7 - Sun
  //   // holiday is 0-7 value ... with 0 being the non-holiday thing
  //   String startDay = 'Mon';
  //   String endDay = 'Sun';
  //   if (widget.service.holiday != 0) {
  //     if (widget.service.holiday == 1) {
  //       startDay = 'Tue';
  //     } else if (widget.service.holiday == 7) {
  //       endDay = 'Sat';
  //     } else {
  //       startDay = getDayForNumber(widget.service.holiday + 1);
  //       endDay = getDayForNumber(widget.service.holiday - 1);
  //     }
  //   }
  //   if (widget.service.timings.length > 1)
  //     return Text(
  //       '$startDay  ${widget.service.timings[0]} \n$endDay  ${widget.service.timings[1]}',
  //       style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w400),
  //     );
  //   return Row(
  //     children: [
  //       SizedBox(width: 8),
  //       Column(
  //         children: [
  //           Text(
  //             '$startDay  ',
  //             style: kHeading18,
  //           ),
  //           Text('$endDay  ', style: kHeading18)
  //         ],
  //       ),
  //       SizedBox(width: 8),
  //       // Text(
  //       // widget.service.timings[0],
  //       // style: kHeading18,
  //       // )
  //     ],
  //   );
  // }

  String getTimingForNumber(int number) {
    //Parameter is number as it is coming in string format

    List<String> timings = widget.service.timings[number.toString()];

    if (timings == null || timings.length == 0) {
      return 'Closed';
    }

    String a = "";
    // a = timings.join("-");
    for (int i = 0; i < timings.length; i += 2) {
      String first = timings[i];
      String second = timings[i + 1];
      a += first + "-" + second + "\n";
    }
    return a;
  }

  Widget createTimings() {
    return Expanded(
      child: Container(
        height: 400,
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 7; i++)
              ListTile(
                leading: Text(getDayForNumber(i)),
                trailing: Text(getTimingForNumber(i)),
              )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.serviceType,
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: kPrimaryColor,
      ),
      backgroundColor: kPrimaryColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(displayWidth(context) * 0.02),
              child: FloatingActionButton(
                heroTag: 'Go',
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.directions,
                      color: kWhiteBackgroundColor,
                      // size: displayHeight(context) * 0.04,
                    ),
                    Text(
                      'Go',
                      style: kHeading11.copyWith(color: kWhiteBackgroundColor),
                    ),
                  ],
                ),
                backgroundColor: kPrimaryColor,
                onPressed: () {
                  openMapsForDirectionNow(widget.service.latitude,
                      widget.service.longitude, widget.service.address);
                },
              ),
            ),
            SizedBox(
              height: 8,
            ),
            FloatingActionButton(
              heroTag: 'call',
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.call,
                    color: kWhiteBackgroundColor,
                    // size: displayHeight(context) * 0.03,
                  ),
                  Text(
                    'Call',
                    style: kHeading11.copyWith(color: kWhiteBackgroundColor),
                  ),
                ],
              ),
              backgroundColor: kPrimaryColor,
              onPressed: () {
                callNow(widget.service.phoneNumber);
              },
            ),
            SizedBox(
              height: displayHeight(context) * 0.1,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                // height: displayHeight(context),
                width: double.infinity,
                decoration: kBackgroundBoxDecoration(),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      child: Row(
                        children: [
                          Container(
                            width: displayWidth(context) * 0.65,
                            child: Text("${widget.service.name}",
                                maxLines: 2,
                                softWrap: true,
                                style: kHeading22.copyWith(
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => ZoomImage(
                                      imageUrl: widget.service.images[0])));
                            },
                            child: Container(
                              // height: displayHeight(context) * 0.24,
                              height: fitToHeight(220, context),
                              width: displayWidth(context),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        NetworkImage(widget.service.images[0])),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          Column(
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: kPrimaryColor,
                                          size: displayHeight(context) * 0.04,
                                        ),
                                        SizedBox(
                                            height:
                                                displayHeight(context) * 0.03),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Container(
                                      width: displayWidth(context) * 0.62,
                                      child: Text(
                                        '${widget.service.address}',
                                        maxLines: 3,
                                        softWrap: true,
                                        style: kHeading18,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: kPrimaryColor,
                                    size: displayHeight(context) * 0.04,
                                  ),
                                  SizedBox(
                                      width: displayWidth(context) * 0.025),
                                  // Image.asset(
                                  //   'assets/images/sign.png',
                                  //   height: displayHeight(context) * 0.08,
                                  // ),
                                  // formTimings(),
                                  createTimings()
                                ],
                              ),
                              // SizedBox(
                              //   height: displayHeight(context) * 0.02,
                              // ),
                              SizedBox(
                                height: 8,
                              ),
                              //TODO: List tile widget instead of row.

                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: kPrimaryColor,
                                    size: displayHeight(context) * 0.04,
                                  ),
                                  SizedBox(width: displayWidth(context) * 0.05),
                                  Text(
                                    '${widget.service.rating}',
                                    style: kHeading18,
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow[600],
                                    size: displayHeight(context) * 0.02,
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   height: displayHeight(context) * 0.02,
                              // ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Image.asset('assets/images/direction.png',
                                      height: displayHeight(context) * 0.04,
                                      width: displayHeight(context) * 0.04),
                                  SizedBox(width: displayWidth(context) * 0.05),
                                  Text(
                                    '${widget.service.distance}',
                                    style: kHeading18,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'km',
                                    style: kHeading18,
                                  ),
                                ],
                              ),
                              SizedBox(height: 24),
                            ],
                          ),
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
