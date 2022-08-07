import 'package:flutter/material.dart';
import 'package:pet_perfect_app/common/bloc/pet_registration_bloc/pet_registration_bloc.dart';
import 'package:pet_perfect_app/SideBarPages/order_page.dart';
import 'package:pet_perfect_app/screens/components/custom_Icon_list_tiles.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import 'package:pet_perfect_app/SideBarPages/emergency_page.dart';
import 'package:pet_perfect_app/SideBarPages/regis_screen.dart';
import 'package:pet_perfect_app/SideBarPages/view_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_perfect_app/authentication/bloc/authentication_bloc.dart';
import 'package:pet_perfect_app/registration/registration.dart';
import 'package:pet_perfect_app/utils/font_style_helpers.dart';
import 'package:pet_perfect_app/utils/local_db_hive.dart';

class SideBar extends StatefulWidget {
  final String userName;
  final String userImage;

  SideBar({
    Key key,
    this.userImage,
    this.userName,
  }) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  String userName;
  String userImage;
  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<Map<String, String>> _getUserData() async {
    userName = LocalDb.userName;
    userImage = LocalDb.userImage;

    final map = {
      "userName": userName,
      "userImage": userImage,
    };
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          FutureBuilder(
              future: _getUserData(),
              builder: (context, snapshot) {
                print(snapshot.data);
                return Container(
                    padding: EdgeInsets.zero,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      color: kPrimaryColor,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 25),
                              InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => BlocProvider(
                                                create: (context) =>
                                                    PetRegistrationBloc(),
                                                child: ViewProfilePage(
                                                  userImage: widget.userImage,
                                                  userName: widget.userName,
                                                  // userName: prefs.getUserName(),
                                                  // userImage: prefs.getUserImage(),
                                                ))));
                                  },
                                  child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                          snapshot.data["userImage"]))),
                            ],
                          ),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => BlocProvider(
                                              create: (context) =>
                                                  PetRegistrationBloc(),
                                              child: ViewProfilePage(
                                                userImage: widget.userImage,
                                                userName: widget.userName,
                                              ))));
                                },
                                child: Text(
                                  // userName,
                                  snapshot.data["userName"],
                                  style: kHeading16.copyWith(
                                      color: kWhiteBackgroundColor),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => BlocProvider(
                                              create: (context) =>
                                                  PetRegistrationBloc(),
                                              child: ViewProfilePage(
                                                userImage: widget.userImage,
                                                userName: widget.userName,
                                              ))));
                                },
                                child: Text(
                                  'View Profile',
                                  style: kHeading14.copyWith(
                                      color: kWhiteBackgroundColor),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 70),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset('assets/images/menu.png'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ));
              }),
          SizedBox(height: 20),
          IconListTile(userImage: widget.userImage, userName: widget.userName),
        ],
      ),
    );
  }
}

class IconListTile extends StatelessWidget {
  final userName;
  final userImage;
  IconListTile({this.userImage, this.userName});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: [
          CustomIconListTile(
            press: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EmergencyPage(
                            userImage: userImage,
                            userName: userName,
                          )));
            },
            icon: 'assets/images/emergency.png',
            text: 'Emergency',
            color: kredBackgroundColor,
          ),
          SizedBox(height: 20),
          CustomIconListTile(
            press: () {},
            icon: 'assets/images/store (2).png',
            text: 'Store',
            color: primaryTextColor,
          ),
          SizedBox(height: 20),
          CustomIconListTile(
            press: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrderPage()));
            },
            icon: 'assets/images/order.png',
            text: 'My Orders',
            color: primaryTextColor,
          ),
          SizedBox(height: 20),
          CustomIconListTile(
            press: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => BlocProvider(
                          create: (context) => PetRegistrationBloc(),
                          child: RegisScreen(
                            userImage: userImage,
                            userName: userName,
                          ))));
            },
            icon: 'assets/images/registration.png',
            text: 'Registration',
            color: primaryTextColor,
          ),
          SizedBox(height: 20),
          CustomIconListTile(
            press: () {},
            icon: 'assets/images/setting.png',
            text: 'Settings',
            color: primaryTextColor,
          ),
          SizedBox(height: 20),
          CustomIconListTile(
            press: () {},
            icon: 'assets/images/emergency.png',
            text: 'Invite Friends',
            color: primaryTextColor,
          ),
          SizedBox(height: 20),
          CustomIconListTile(
            press: () {},
            icon: 'assets/images/about us.png',
            text: 'About Us',
            color: primaryTextColor,
          ),
          SizedBox(height: 20),
          CustomIconListTile(
            press: () {},
            icon: 'assets/images/query.png',
            text: 'Pet queries',
            color: primaryTextColor,
          ),
          SizedBox(height: 20),
          CustomIconListTile(
            press: () {},
            icon: 'assets/images/chat.png',
            text: 'Contact Us',
            color: primaryTextColor,
          ),
          Divider(),
          ListTile(
            onTap: () {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogOutEvent());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => RegistrationBloc(
                        authenticationBloc:
                            BlocProvider.of<AuthenticationBloc>(context)),
                    child: RegistrationScreen(),
                  ),
                ),
              );
            },
            title: Text(
              "Log out",
              style: kHeading20,
            ),
          ),
        ],
      ),
    );
  }
}
