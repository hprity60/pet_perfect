//SERVICE LIST IS THE LIST ITEM ON THE SERVICES PAGE
import 'package:flutter/material.dart';
import 'package:pet_perfect_app/common/widgets/call_now.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'dart:ui';
import 'package:pet_perfect_app/logger.dart';

class ServiceListTile extends StatelessWidget {
  const ServiceListTile(
      {Key key,
      this.serviceProvider,
      this.timings,
      this.review,
      this.distance,
      this.press,
      this.image,
      this.phoneNumber,
      this.serviceType})
      : super(key: key);
  final String serviceProvider,
      image,
      review,
      distance,
      phoneNumber,
      serviceType;
  final Function press;
  final Map<String, List<String>> timings;

  bool open(int number) {
    List<String> list = timings[number.toString()];
    if (list.isEmpty || list == null) {
      return false;
    }
    return true;
  }

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

  Widget getOpenOrClosedDays() {
    return Row(
      children: [
        for (int i = 0; i < 7; i++)
          Padding(
            padding: const EdgeInsets.only(top: 3, bottom: 3),
            child: DayCircle(
              label: getDayForNumber(i)[0],
              open: open(i),
            ),
          )
      ],
    );
  }

  bool openRightNow() {
    bool a = false;
    DateTime now = DateTime.now();
    int nowDay;

    if (now.weekday == 7) {
      nowDay = 0;
    } else {
      nowDay = now.weekday;
    }
    List<String> list = timings[nowDay.toString()];

    if (list.length <= 1 || list == null) {
      return false;
    }
    for (int i = 0; i < list.length; i += 2) {
      int hour = int.parse(list[i].substring(0, 2));
      int minutes = int.parse(list[i].substring(2, 4));

      int hour2 = int.parse(list[i + 1].substring(0, 2));
      int minutes2 = int.parse(list[i + 1].substring(2, 4));
      DateTime firstTime =
          DateTime(now.year, now.month, now.day, hour, minutes);
      DateTime secondTime =
          DateTime(now.year, now.month, now.day, hour2, minutes2);

      if (now.isAfter(firstTime) && now.isBefore(secondTime)) {
        a = true;
      }
    }
    return a;
  }

  @override
  Widget build(BuildContext context) {
    // fit: StackFit.expand,
    return Stack(
      children: [
        InkWell(
          onTap: press,
          child: Card(
            // margin: EdgeInsets.all(4),
            // padding: EdgeInsets.all(3),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Container(
              margin: EdgeInsets.all(3),
              padding: EdgeInsets.all(3),
              child: Container(
                width: double.infinity,
                decoration: kBox20Decoration(),
                // SizedBox(
                //   height: 12,
                // ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(width: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Container(
                          height: displayHeight(context) * 0.12,
                          width: displayWidth(context) * 0.25,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(image),
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: displayWidth(context) * 0.4,
                            child: Text(
                              serviceProvider,
                              softWrap: true,
                              maxLines: 2,
                              style: kHeading16,
                            ),
                          ),
                          // Text(
                          //   time,
                          //   style: kHeading14,
                          // ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 5.0, bottom: 5.0),
                            child: Row(
                              // mainAxisAlignment:
                              // MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: Text("$serviceType"),
                                ),
                                // Spacer(),
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: openRightNow()
                                          ? Colors.green
                                          : Colors.red,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Text(
                                    openRightNow() ? " Open " : "Closed Now",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                review,
                                style: kHeading14,
                              ),
                              Image.asset('assets/images/star.png'),
                              SizedBox(width: 24),
                              Text(
                                distance,
                                style: kHeading14,
                              ),
                            ],
                          ),
                          getOpenOrClosedDays(),
                        ],
                      ),
                      // Text(openRightNow() ? "Open" : "Closed"),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 16),
                        child: InkWell(
                          onTap: () {
                            callNow((phoneNumber));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/call.png'),
                              Text(
                                'Call',
                                style: kHeading11,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Positioned.fill(
                  //   child: BackdropFilter(
                  //     filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  //     child: Container(
                  //       color: Colors.transparent,
                  //     ),
                  //   ),
                  // ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DayCircle extends StatelessWidget {
  const DayCircle({
    Key key,
    @required this.label,
    @required this.open,
  }) : super(key: key);
  final String label;
  final bool open;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black),
        color: open ? Colors.green : Colors.white,
      ),
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.all(1),
      child: Center(
        child: Text(
          label,
          style: TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}
