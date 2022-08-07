import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_perfect_app/profile/generic_profile.dart';
import 'package:pet_perfect_app/screens/Food/food_page.dart';
import 'package:pet_perfect_app/home/view/home_page.dart';
import 'package:pet_perfect_app/screens/Info/info_page.dart';
import 'package:pet_perfect_app/services/view/particular_service_view_all_page.dart';
import 'package:pet_perfect_app/services/unused/services_page.dart';
import 'package:pet_perfect_app/profile/main_profile_page.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';
import '../home/export.dart';

class BottomNavigatorPage extends StatefulWidget {
  @override
  _BottomNavigatorPageState createState() => _BottomNavigatorPageState();
}

class _BottomNavigatorPageState extends State<BottomNavigatorPage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    FoodPage(),
    // ServicesPage(),
    ParticularServiceViewAll(),
    InfoPage(),
    GenericProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      // body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/home (2).png',
            ),
            backgroundColor: kPrimaryColor,
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/food (2).png',
              ),
              backgroundColor: kPrimaryColor,
              label: 'Food'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/service.png',
              ),
              backgroundColor: kPrimaryColor,
              label: 'Services'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/wiki.png',
                height: 24,
              ),
              backgroundColor: kPrimaryColor,
              label: 'Wiki'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/pets.png',
              ),
              backgroundColor: kPrimaryColor,
              label: 'Pet Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedFontSize: 10,
        selectedLabelStyle: GoogleFonts.poppins(color: Colors.white),
        onTap: _onItemTapped,
      ),
    );
  }
}
