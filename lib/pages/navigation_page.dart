import 'package:boboloc/models/car_model.dart';
import 'package:boboloc/pages/calendar_page.dart';
import 'package:boboloc/pages/car_details_page.dart';
import 'package:boboloc/pages/cars_list_page.dart';
import 'package:boboloc/pages/contact_us_page.dart';
import 'package:boboloc/pages/create_new_car_page.dart';
import 'package:boboloc/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _navigationIndex = 0;
  List<Widget> navigationMainPages = [
    CarsListPage(),
    CalendarPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationMainPages[_navigationIndex],
      bottomNavigationBar: GNav(
        color: const Color.fromRGBO(133, 133, 133, 1),
        activeColor: const Color.fromRGBO(113, 101, 227, 1),
        gap: 4,
        onTabChange: (index) {
          setState(() {
            _navigationIndex = index;
          });
        },
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Accueil',
          ),
          GButton(
            icon: Icons.calendar_month,
            text: 'Calendrier',
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
          ),
        ],
      ),
    );
  }
}
