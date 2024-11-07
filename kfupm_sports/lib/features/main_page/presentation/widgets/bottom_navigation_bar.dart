import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigationBarWidget({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Color(0xFFE2B56F), // Set background color here
      selectedItemColor: Colors.white, // Set highlight color here
      unselectedItemColor: Colors.black, // Optional: set unselected item color
      items: [
        _buildBottomNavigationBarItem(
          icon: Icons.event, // Calendar icon
          label: 'Events',
          isSelected: currentIndex == 0,
        ),
        _buildBottomNavigationBarItem(
          icon: Icons.home, // Home icon
          label: 'Home',
          isSelected: currentIndex == 1,
        ),
        _buildBottomNavigationBarItem(
          icon: Icons.person, // User icon
          label: 'Profile',
          isSelected: currentIndex == 2,
        ),
      ],
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(8), // Padding around the icon
        child: Icon(icon),
      ),
      label: label,
    );
  }
}
