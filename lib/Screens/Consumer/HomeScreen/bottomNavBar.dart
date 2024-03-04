import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar();
  State<BottomNavBar> createState() => _BottomNavBar();
}
class _BottomNavBar extends State<BottomNavBar> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Appointments',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.watch_later),
          label: 'Orders',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: _onItemTapped,
    );
  }
}