import 'package:flutter/material.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';

class OrderLists extends StatelessWidget {
  const OrderLists({
    Key key,
    this.image,
    this.productDetail,
    this.date,
  }) : super(key: key);
  final String image, productDetail;
  final int date;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        // alignment: Alignment.center,
        // height: displayHeight(context) * 0.18,
        // width: displayWidth(context),
        width: double.infinity,
        decoration: kBox20Decoration(),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    // height: displayHeight(context) * 0.12,
                    // width: displayWidth(context) * 0.25,

                    child: Image.asset(
                      image,
                      width: displayWidth(context) * 0.25,
                      height: displayHeight(context) * 0.16,
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        productDetail,
                        style: kHeading14,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Delivered: ${date} Jan 2020',
                        style: kHeading11.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            'Ordered: ',
                            style: kHeading13.copyWith(
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${date} Jan 2020',
                            style: kHeading13,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Received by: ',
                                style: kHeading13.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Home',
                                style: kHeading13,
                              ),
                            ],
                          ),
                          SizedBox(width: 24),
                          InkWell(
                              enableFeedback: true,
                              focusColor: Colors.blue,
                              splashColor: Colors.yellow,
                              highlightColor: Colors.green,
                              onTap: () {
                                print('reorder');
                              },
                              child: Text('Reorder',style: kHeading14.copyWith(color: Colors.blue,fontWeight: FontWeight.bold),),
                            ),
                            
                         
                          // TextButton(
                          //   onPressed: () {},
                          //   child: Text(
                          //     'Reorder',
                          //     style: kHeading14.copyWith(
                          //         color: Colors.blue,
                          //         fontWeight: FontWeight.bold),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
