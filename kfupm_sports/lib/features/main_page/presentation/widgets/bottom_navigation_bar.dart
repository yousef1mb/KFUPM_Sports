import 'package:flutter/material.dart';
import 'package:kfupm_sports/core/theme/app_colors.dart'; // Update this path based on your structure

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
      backgroundColor: AppColors.navigationBar, // Set background color here
      selectedItemColor: AppColors.primary, // Set highlight color here
      unselectedItemColor:
          AppColors.headLineFontColor, // Optional: set unselected item color
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
          color: isSelected
              ? AppColors.navigationBarHighlight
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(8), // Padding around the icon
        child: Icon(icon),
      ),
      label: label,
    );
  }
}
