// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:kfupm_sports/core/theme/app_colors.dart';
import 'package:kfupm_sports/features/main_page/presentation/views/events_page_view.dart';
import 'package:kfupm_sports/features/main_page/presentation/views/main_page_view.dart';
import 'package:kfupm_sports/features/main_page/presentation/views/profile_page_view.dart';

class PagesView extends StatefulWidget {
  const PagesView({super.key});

  @override
  _MainPageViewState createState() => _MainPageViewState();
}

class _MainPageViewState extends State<PagesView> {
  var _currentIndex = 1;
  final _pages = [
    const EventsPageView(),
    const MainPageView(),
    const ProfilePageView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _currentIndex >= _pages.length ? null : _pages[_currentIndex];
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(24),
            topLeft: Radius.circular(24),
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            backgroundColor:
                AppColors.navigationBar, // Set background color here
            selectedItemColor: AppColors.primary, // Set highlight color here
            unselectedItemColor: AppColors
                .headLineFontColor, // Optional: set unselected item color
            items: [
              _buildBottomNavigationBarItem(
                icon: Icons.event, // Calendar icon
                label: 'Events',
                isSelected: _currentIndex == 0,
              ),
              _buildBottomNavigationBarItem(
                icon: Icons.home, // Home icon
                label: 'Home',
                isSelected: _currentIndex == 1,
              ),
              _buildBottomNavigationBarItem(
                icon: Icons.person, // User icon
                label: 'Profile',
                isSelected: _currentIndex == 2,
              ),
            ],
          ),
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
