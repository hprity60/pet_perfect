import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/common/widgets/custom_detail_text_box.dart';
import 'package:pet_perfect_app/common/widgets/custom_text_box.dart';
import 'package:pet_perfect_app/shop/view/payment.dart';
import 'package:pet_perfect_app/screens/components/default_button.dart';
import 'package:pet_perfect_app/shop/models/shop.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';

class Checkout extends StatefulWidget {
  final List<ShopItem> cartItems;
  Checkout(this.cartItems);
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  Position _currentPosition;

  final _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'checkout');
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  final fullNameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final houseController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pinController = TextEditingController();

  _validate(BuildContext ctx) {
    if (fullNameController.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Please Provide Your Name!!'),
        backgroundColor: kredBackgroundColor,
      ));
    } else if (houseController.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Please Provide Your House No.!'),
        backgroundColor: kredBackgroundColor,
      ));
    }else if (stateController.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Please Provide Your State!'),
        backgroundColor: kredBackgroundColor,
      ));
    } else if (cityController.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Please Provide Your City!'),
        backgroundColor: kredBackgroundColor,
      ));
    } else if (pinController.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Please Provide Your Pin!'),
        backgroundColor: kredBackgroundColor,
      ));
    }  else if (addressController.text.isEmpty) {
     _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Please Provide Your Address!'),
        backgroundColor: kredBackgroundColor,
      ));
    } else if (mobileController.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Please Provide Your Phone Number!'),
        backgroundColor: kredBackgroundColor,
      ));
    } else {
      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PaymentPage(widget.cartItems)));
    }
  }
  // onNextPressed(BuildContext context) {
  //   if (petType == null) {
  //     Scaffold.of(context).showSnackBar(SnackBar(
  //       content: Text('Please Select Your Pet Type!'),
  //       backgroundColor: kredBackgroundColor,
  //     ));
  //   } else if (selectedBreed == null) {
  //     Scaffold.of(context).showSnackBar(SnackBar(
  //       content: Text('Please Enter Your Pet\'s Breed!'),
  //       backgroundColor: kredBackgroundColor,
  //     ));
  //   } else if (_dob == null) {
  //     Scaffold.of(context).showSnackBar(SnackBar(
  //       content: Text('Please Enter Your Pet\'s Birthday!'),
  //       backgroundColor: kredBackgroundColor,
  //     ));
  //   } else if (selectedGender == null) {
  //     Scaffold.of(context).showSnackBar(SnackBar(
  //       content: Text('Please Enter Your Pet\'s Gender!'),
  //       backgroundColor: kredBackgroundColor,
  //     ));
  //   } else {

  //     // Navigator.push(
  //     //   context,
  //     //   MaterialPageRoute(
  //     //     builder: (_) => BlocProvider(
  //     //       create: (context) => _initialProfileBloc,
  //     //       child: InitialProfileSecondPage(
  //     //         petType: petType,
  //     //         birthday: _dob,
  //     //         gender: selectedGender,
  //     //         breed: selectedBreed,
  //     //       ),
  //     //     ),
  //     //   ),
  //     // );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kSecondaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: kSecondaryBackgroundColor,
        title: Text(
          'Delivery Address',
          style: kHeading18,
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: kBlackBackgroundColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // height: displayHeight(context) * 0.08,
                width: displayWidth(context) * 0.99,
                decoration: kBox5Decoration(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ExpansionTile(
                    title: Text(
                      'Show Order Details',
                      style: kHeading14,
                    ),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.cartItems.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            // dense: true,
                            visualDensity: VisualDensity.comfortable,
                            title: Text(
                              widget.cartItems[index].title,
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            trailing: Text(
                              widget.cartItems[index].quantity.toString() +
                                  " X " +
                                  " \$" +
                                  widget.cartItems[index].price.toString(),
                              style: kHeading14,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      height: displayHeight(context) * 0.01,
                      color: kYellowColor,
                    ),
                  ),
                  Positioned(
                    top: -8,
                    left: 27,
                    child: Text(
                      'Delivery within 48 Hours in Delhi NCR',
                      style: kHeading11.copyWith(fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shopping Address',
                    style: kHeading18,
                  ),
                  Row(children: [
                    Icon(
                      Icons.my_location_rounded,
                      color: Colors.blue,
                    ),
                    TextButton(
                        onPressed: () {
                          _getCurrentLocation();
                        },
                        child: Text('Use current location'))
                  ]),
                ],
              ),
              CustomTextBox(
                // hintText: 'Full name',
                labelText: 'Full name',
                textEditingController: fullNameController,
                textInputType: TextInputType.name,
                obscureText: false,
              ),
              CustomTextBox(
                // hintText: 'Flat/House no',
                labelText: 'Flat/House no',
                textEditingController: houseController,
                textInputType: TextInputType.name,
                obscureText: false,
              ),
              CustomTextBox(
                // hintText: 'State',
                labelText: 'State',
                textEditingController: stateController,
                textInputType: TextInputType.name,
                obscureText: false,
              ),
              Row(
                children: [
                  CustomDetailTextBox(
                    // hintText: 'City',
                    labelText: 'City',
                    textEditingController: cityController,
                    textInputType: TextInputType.name,
                    obscureText: false,
                  ),
                  CustomDetailTextBox(
                    // hintText: 'Pin Code',
                    labelText: 'Pin Code',
                    textEditingController: pinController,
                    textInputType: TextInputType.name,
                    obscureText: false,
                  ),
                ],
              ),
              CustomTextBox(
                // hintText: 'Address',
                labelText: 'Address',
                textEditingController: addressController,
                textInputType: TextInputType.name,
                obscureText: false,
              ),
              CustomTextBox(
                // hintText: 'Mobile number',
                labelText: 'Mobile number',
                textEditingController: mobileController,
                textInputType: TextInputType.name,
                obscureText: false,
              ),
              SizedBox(height: 25),
              SizedBox(
                height: displayHeight(context) * 0.066,
                width: double.infinity,
                child: DefaultButton(
                  text: "Continue to payment",
                  textColor: Colors.white,
                  bgColor: kPrimaryColor,
                  press: () {
                    _validate(context);
                  },
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      print('place is : ${place.postalCode}');
      print('locality is : ${place.locality}');
      print('thoroughfare is : ${place.thoroughfare}');
      print('country is : ${place.country}');
      print('subLocality is : ${place.subLocality}');
      print('administrativeArea is : ${place.administrativeArea}');
      print('administrativeArea is : ${place.subAdministrativeArea}');

      setState(() {
        pinController.text = place.postalCode;
        cityController.text = place.country;
        stateController.text = place.administrativeArea;
        streetController.text = place.subLocality;
      });
    } catch (e) {
      print(e);
    }
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }
}
