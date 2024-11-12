import 'package:flutter/material.dart';
import 'package:kfupm_sports/core/theme/app_colors.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigationBarWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          backgroundColor: AppColors.navigationBar, // Set background color here
          selectedItemColor: AppColors.primary, // Set highlight color here
          unselectedItemColor: AppColors
              .headLineFontColor, // Optional: set unselected item color
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
        ),
      ),
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
        padding: const EdgeInsets.all(8), // Padding around the icon
        child: Icon(icon),
      ),
      label: label,
    );
  }
}
