import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/authentication/bloc/authentication_bloc.dart';
import 'package:pet_perfect_app/common/models/user_data.dart';
import 'package:pet_perfect_app/common/widgets/default_text_box.dart';
import 'package:pet_perfect_app/common/widgets/primary_button.dart';
import 'package:pet_perfect_app/initial_profile/bloc/initial_profile_bloc.dart';
import 'package:pet_perfect_app/initial_profile/view/view.dart';
import 'package:pet_perfect_app/login/login.dart';
import 'package:pet_perfect_app/registration/registration.dart';
import 'package:flutter/material.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/local_db_hive.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';

import '../../utils/color_helpers.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _phoneNumberController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _otpController = TextEditingController();

  bool firstNameEnabled;
  bool lastNameEnabled;
  bool phoneNumberEnabled;
  bool showOtpPart;
  bool showLoading;
  String sessionId;

  @override
  void initState() {
    super.initState();
    firstNameEnabled = true;
    lastNameEnabled = true;
    phoneNumberEnabled = true;
    showOtpPart = false;
    showLoading = false;
  }

  onGenerateOtpPressed(BuildContext context) {
    if (_firstNameController.text == '') {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please Enter Your First Name!'),
        backgroundColor: kredBackgroundColor,
      ));
    } else if (_phoneNumberController.text == '' ||
        _phoneNumberController.text.length != 10) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please Enter a valid 10 digit Mobile Number!'),
        backgroundColor: kredBackgroundColor,
      ));
    } else {
      BlocProvider.of<RegistrationBloc>(context).add(
        RegistrationSendOtpPressedEvent(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            phoneNumber: int.parse(_phoneNumberController.text)),
      );
    }
  }

  onVerifyPressedWithOtp(BuildContext context, RegistrationState state) {
    if (_otpController.text == '' || _otpController.text.length != 4) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('OTP should be a 4 digit code'),
        backgroundColor: kredBackgroundColor,
      ));
    } else {
      ///saving phoneNumber,first and last name in user_data.dart
      // UserData.user.saveUserData(_firstNameController.text,
      //     _lastNameController.text, int.parse(_phoneNumberController.text));

      LocalDb.saveInitUserDetails(_firstNameController.text,
          _lastNameController.text, int.parse(_phoneNumberController.text));
      // UserData.user.firstName = _firstNameController.text;
      // UserData.user.lastName = _lastNameController.text;
      // UserData.user.phoneNumber = int.parse(_phoneNumberController.text);

      phoneNumberEnabled = false;
      firstNameEnabled = false;
      lastNameEnabled = false;

      BlocProvider.of<RegistrationBloc>(context).add(
          RegistrationVerifyOtpPressedEvent(
              firstName: _firstNameController.text,
              lastName: _lastNameController.text,
              phoneNumber: int.parse(_phoneNumberController.text),
              sessionId: sessionId,
              enteredOtp: int.parse(_otpController.text)));

      print("session id is : $sessionId");
      print("otp is otp");
    }
  }

  onEnterAnotherMobilePressed(BuildContext context) {
    BlocProvider.of<RegistrationBloc>(context)
        .add(RegistrationInitializedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: Center(
          child: Text(
            "Pet Perfect",
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
                fontSize: 25, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
      ),
      body: BlocListener<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          if (state is RegistrationInitialState) {
            _phoneNumberController.clear();
            _firstNameController.clear();
            _lastNameController.clear();
            _otpController.clear();
            showLoading = false;
            showOtpPart = false;
            firstNameEnabled = true;
            lastNameEnabled = true;
            phoneNumberEnabled = true;
          }
          if (state is RegistrationSendOtpPressedFailedState) {
            showLoading = false;
            phoneNumberEnabled = true;
            firstNameEnabled = true;
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ));
          }
          if (state is RegistrationSendOtpPressedLoadingState) {
            showLoading = true;
          }
          if (state is RegistrationVerifyOtpState) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ));
            showOtpPart = true;
            showLoading = false;
            phoneNumberEnabled = false;
            firstNameEnabled = false;
            lastNameEnabled = false;
            sessionId = state.sessionId;
          }
          if (state is RegistrationVerifyOtpPressedLoadingState) {
            showLoading = true;
          }
          if (state is RegistrationVerifyOtpPressedFailedState) {
            showLoading = false;
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ));
          }
          if (state is RegistrationVerifyOtpSuccessfullState) {
            showLoading = false;
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) =>
                            BlocProvider.of<AuthenticationBloc>(context),
                      ),
                      BlocProvider(
                        create: (context) => InitialProfileBloc(),
                      )
                    ],
                    child: InitialProfileFirstPage(),
                  ),
                ),
                (Route<dynamic> route) => false);
          }
        },
        child: BlocBuilder<RegistrationBloc, RegistrationState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      height: displaySize(context).height * 0.06,
                      width: double.infinity,
                      color: kPrimaryColor,
                      child: Text(
                        'Registration',
                        style:
                            kHeading28.copyWith(color: kWhiteBackgroundColor),
                      ),
                    ),
                    Container(
                      height: displaySize(context).height * 0.02,
                      width: double.infinity,
                      color: kPrimaryColor,
                    ),
                    SingleChildScrollView(
                      child: Container(
                        height: displayHeight(context) * 0.55,
                        child: Stack(
                          children: [
                            Container(
                              height: displayHeight(context) * 0.3,
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                              ),
                            ),
                            Positioned(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                height: displayHeight(context) * 0.8,
                                width: double.infinity,
                                decoration: kBoxDecoration(),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      DefaultTextBox(
                                        hintText: 'First Name',
                                        labelText: 'First Name',
                                        textEditingController:
                                            _firstNameController,
                                        textInputType: TextInputType.name,
                                        obscureText: false,
                                        enabled: firstNameEnabled,
                                      ),
                                      DefaultTextBox(
                                        hintText: 'Last Name',
                                        labelText: 'Last Name',
                                        textEditingController:
                                            _lastNameController,
                                        textInputType: TextInputType.name,
                                        obscureText: false,
                                        enabled: lastNameEnabled,
                                      ),
                                      DefaultTextBox(
                                        hintText: 'Phone Number',
                                        labelText: 'Phone Number',
                                        textEditingController:
                                            _phoneNumberController,
                                        textInputType: TextInputType.phone,
                                        obscureText: false,
                                        enabled: phoneNumberEnabled,
                                      ),
                                      if (showOtpPart)
                                        DefaultTextBox(
                                          hintText: 'Enter the OTP received',
                                          labelText: 'OTP',
                                          textEditingController: _otpController,
                                          textInputType: TextInputType.number,
                                          obscureText: false,
                                          enabled: true,
                                        )
                                      else
                                        Container(),
                                      if (showLoading)
                                        Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      else
                                        Builder(
                                          builder: (context) => PrimaryButton(
                                            title: showOtpPart
                                                ? 'Verify'
                                                : 'Generate OTP',
                                            onPressed: () => {
                                              if (showOtpPart)
                                                onVerifyPressedWithOtp(
                                                    context, state)
                                              else
                                                onGenerateOtpPressed(context),
                                            },
                                          ),
                                        ),
                                      showOtpPart
                                          ? Container()
                                          : Padding(
                                              padding: showOtpPart
                                                  ? const EdgeInsets.all(0.0)
                                                  : const EdgeInsets.all(5.0),
                                              child: Center(
                                                child: Text(
                                                  'A code will be sent to your phone',
                                                  style: kHeading14.copyWith(
                                                      color:
                                                          secondaryTextColor),
                                                  // color: secondaryTextColor,
                                                ),
                                              ),
                                            ),
                                      SizedBox(
                                        height: displayHeight(context) * 0.06,
                                      ),
                                      showOtpPart
                                          ? GestureDetector(
                                              onTap: () =>
                                                  onEnterAnotherMobilePressed(
                                                      context),
                                              child: Center(
                                                child: Text(
                                                  "Enter another number",
                                                  style: kHeading16.copyWith(
                                                      color: kPrimaryColor),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: showOtpPart
                          ? displayHeight(context) * 0.00
                          : displayHeight(context) * 0.06,
                    ),
                    FlatButton(
                        onPressed: () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => LoginBloc(
                                  authenticationBloc:
                                      BlocProvider.of<AuthenticationBloc>(
                                          context),
                                ),
                                child: LoginPage(),
                              ),
                            ),
                            (Route<dynamic> route) => false),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already a user? ',
                              textAlign: TextAlign.center,
                              style: kHeading14,
                            ),
                            Text(
                              ' Login',
                              textAlign: TextAlign.center,
                              style: kHeading14.copyWith(color: kPrimaryColor),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
