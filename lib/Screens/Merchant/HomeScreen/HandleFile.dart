import 'package:flutter/material.dart';
import 'Home_Screen.dart';
import '../ManageOrdersScreen/Manage_Orders_Screen.dart';

class HandleFile2 extends StatefulWidget {

  State<HandleFile2> createState() => _HandleFile2();
}

class _HandleFile2 extends State<HandleFile2> {

  int _selectedIndex = 0;
  static final List<Widget> _screens = <Widget>[
    MerchantHomePage(),
    Container(),
    MyOrdersScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue.shade50,
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
            icon: Icon(Icons.timeline),
            label: 'Manage Orders',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );

  }
}