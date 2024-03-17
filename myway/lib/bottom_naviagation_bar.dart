import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) changeIndex;

  BottomNavBar({required this.selectedIndex, required this.changeIndex, required Null Function(dynamic index) onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: changeIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_applications_rounded),
          label: 'Laundry',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.phone),
          label: 'Helpline',
        ),
      ],
    );
  }
}