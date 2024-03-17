import 'package:flutter/material.dart';
import 'Home_Screen.dart';
import '../MyOrdersScreen/My_Orders_Screen.dart';

class HandleFile extends StatefulWidget {

  State<HandleFile> createState() => _HandleFile();
}

class _HandleFile extends State<HandleFile> {

  int _selectedIndex = 0;
  static final List<Widget> _screens = <Widget>[
    HomePage(),
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
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: 'Orders',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );

  }
}