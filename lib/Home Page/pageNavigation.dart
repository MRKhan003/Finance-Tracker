import 'package:expense_tracker/CardsScreen/NewExpenseScreen.dart';
import 'package:expense_tracker/CardsScreen/newTrackingScreen.dart';
import 'package:expense_tracker/Home%20Page/home.dart';
import 'package:flutter/material.dart';

class PageNavigation extends StatefulWidget {
  @override
  State<PageNavigation> createState() => _PageNavigationState();
}

class _PageNavigationState extends State<PageNavigation> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;
  late String monthName;

  List<Widget> pages = [
    HomePage(),
    NewTracking(),
    NewExpense(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.money,
            ),
            label: 'New Tracking',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
            ),
            label: 'Add Expense',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber,
        onTap: _onItemTapped,
      ),
    );
  }
}
