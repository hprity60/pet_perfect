import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/authentication/bloc/authentication_bloc.dart';
import 'package:pet_perfect_app/common/widgets/primary_button.dart';
import 'package:pet_perfect_app/home/export.dart';
import 'package:pet_perfect_app/login/login.dart';
import 'package:flutter/material.dart';
import 'package:pet_perfect_app/profile/bloc/pet_profile_bloc.dart';
import 'package:pet_perfect_app/registration/registration.dart';
import 'package:pet_perfect_app/registration/view/view.dart';
import 'package:pet_perfect_app/common/bottom_navigator.dart';
import 'package:pet_perfect_app/screens/Food/bloc/food_bloc.dart';
import 'package:pet_perfect_app/screens/Info/bloc/info_bloc.dart';
import 'package:pet_perfect_app/services/bloc/services_bloc.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/size_helpers.dart';
import 'package:pet_perfect_app/common/widgets/default_text_box.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _phoneNumberController = TextEditingController();
  final _otpController = TextEditingController();

  bool phoneNumberEnabled;
  bool showOtpPart;
  bool showLoading;
  String sessionId;

  @override
  void initState() {
    super.initState();
    phoneNumberEnabled = true;
    showOtpPart = false;
    showLoading = false;
  }

  onGenerateOtpPressed(BuildContext context) {
    if (_phoneNumberController.text == '' ||
        _phoneNumberController.text.length != 10) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please Enter a valid phone!'),
        backgroundColor: kredBackgroundColor,
      ));
    } else {
      BlocProvider.of<LoginBloc>(context).add(
        LoginSendOtpPressedEvent(
            phoneNumber: int.parse(_phoneNumberController.text)),
      );
    }
  }

  onVerifyPressedWithOtp(BuildContext context, LoginState state) {
    if (_otpController.text == '' || _otpController.text.length != 4) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('OTP should be a 4 digit code'),
        backgroundColor: kredBackgroundColor,
      ));
    } else {
      BlocProvider.of<LoginBloc>(context).add(LoginVerifyOtpPressedEvent(
          phoneNumber: int.parse(_phoneNumberController.text),
          sessionId: sessionId,
          enteredOtp: int.parse(_otpController.text)));
    }
  }

  onEnterAnotherMobilePressed(BuildContext context) {
    BlocProvider.of<LoginBloc>(context).add(LoginInitializedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: Center(
          child: Text(
            "Pet Perfect",
            style: GoogleFonts.poppins(
                fontSize: 25, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginInitialState) {
              _phoneNumberController.clear();
              _otpController.clear();
              showLoading = false;
              showOtpPart = false;
              phoneNumberEnabled = true;
            }
            if (state is LoginSendOtpPressedFailedState) {
              showLoading = false;
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('${state.error}'),
                backgroundColor: kredBackgroundColor,
              ));
            }
            if (state is LoginSendOtpPressedLoadingState) {
              showLoading = true;
            }
            if (state is LoginVerifyOtpState) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ));
              showOtpPart = true;
              showLoading = false;
              phoneNumberEnabled = false;
              sessionId = state.sessionId;
            }
            if (state is LoginVerifyOtpPressedLoadingState) {
              showLoading = true;
            }
            if (state is LoginVerifyOtpPressedFailedState) {
              showLoading = false;
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('${state.error}'),
                backgroundColor: kredBackgroundColor,
              ));
            }
            if (state is LoginVerifyOtpSuccessfullState) {
              print("Hellllloooooooo!!!!!!....Login.dart");
              showLoading = false;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) =>
                                    BlocProvider.of<AuthenticationBloc>(
                                        context),
                              ),
                              BlocProvider(create: (context) => HomeBloc()),
                              BlocProvider(create: (context) => FoodBloc()),
                              BlocProvider(create: (context) => ServicesBloc()),
                              BlocProvider(create: (context) => InsightsBloc()),
                              BlocProvider(
                                  create: (context) => PetProfileBloc()),
                            ],
                            child: BottomNavigatorPage(),
                          )),
                  (Route<dynamic> route) => false);
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
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
                          'Login',
                          style: kHeading28,
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10),
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
                                            textEditingController:
                                                _otpController,
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
                                                              secondaryTextColor)
                                                      //color: secondaryTextColor,

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
                                  create: (context) => RegistrationBloc(
                                    authenticationBloc:
                                        BlocProvider.of<AuthenticationBloc>(
                                            context),
                                  ),
                                  child: RegistrationScreen(),
                                ),
                              ),
                              (Route<dynamic> route) => false),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'New user? ',
                                textAlign: TextAlign.center,
                                style: kHeading14,
                              ),
                              Text(' Register',
                                  textAlign: TextAlign.center,
                                  style: kHeading14.copyWith(
                                      color: kPrimaryColor)),
                            ],
                          )),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
