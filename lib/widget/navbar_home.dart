import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';
import 'package:do_with_me/calendar/calendar.dart';
import 'package:do_with_me/core/styles/colors.dart';
import 'package:do_with_me/home_screen/home_screen.dart';
import 'package:do_with_me/profil/profil.dart';
import 'package:do_with_me/todo/todo_page.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _bottomNavIndex = 0;
  static const String _headlineText = 'Home';

  final List<Widget> _listWidget = [
    const HomeScreen(),
    const ToDoPage(),
    const CalendarPage(),
    const ProfilPage(),
  ];

  final List<TabData> _bottomNavBarItems = [
    TabData(
      icon: Icons.home,
      title: _headlineText,
    ),
    TabData(
      icon: Icons.calendar_today,
      title: 'To Do ',
    ),
    TabData(
      icon: Icons.calendar_month,
      title: 'Calendar',
    ),
    TabData(
      icon: Icons.person,
      title: 'Profile',
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewPadding = MediaQuery.of(context).viewPadding;
    double barHeight;
    double barHeightWithNotch = 67;
    double arcHeightWithNotch = 67;

    if (size.height > 700) {
      barHeight = 70;
    } else {
      barHeight = size.height * 0.1;
    }

    if (viewPadding.bottom > 0) {
      barHeightWithNotch = (size.height * 0.07) + viewPadding.bottom;
      arcHeightWithNotch = (size.height * 0.075) + viewPadding.bottom;
    }

    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: CircleBottomNavigationBar(
        initialSelection: _bottomNavIndex,
        barHeight: viewPadding.bottom > 0 ? barHeightWithNotch : barHeight,
        arcHeight: viewPadding.bottom > 0 ? arcHeightWithNotch : barHeight,
        itemTextOff: viewPadding.bottom > 0 ? 0 : 1,
        itemTextOn: viewPadding.bottom > 0 ? 0 : 1,
        circleOutline: 15.0,
        shadowAllowance: 0.0,
        circleSize: 50.0,
        blurShadowRadius: 50.0,
        circleColor: kPurple,
        activeIconColor: kWhite,
        inactiveIconColor: Colors.grey,
        tabs: _bottomNavBarItems,
        onTabChangedListener: _onBottomNavTapped,
      ),
    );
  }
}