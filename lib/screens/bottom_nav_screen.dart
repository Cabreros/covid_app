import 'package:current_cases_app/screens/home_screen.dart';
import 'package:current_cases_app/screens/stats_screen.dart';
import 'package:current_cases_app/screens/vax_screen.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  final List _screens = [
    HomeScreen(),
    VaxScreen(),
    StatsScreen(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffe27d60),
        selectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            label: '',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
