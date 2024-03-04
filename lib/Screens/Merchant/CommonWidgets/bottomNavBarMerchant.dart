import 'package:flutter/material.dart';

class BottomNavBarMerchant extends StatefulWidget {
  const BottomNavBarMerchant();
  State<BottomNavBarMerchant> createState() => _BottomNavBarMerchant();
}
class _BottomNavBarMerchant extends State<BottomNavBarMerchant> {

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
          label: 'All Appointments',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.manage_search),
          label: 'Manage Orders',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: _onItemTapped,
    );
  }
}