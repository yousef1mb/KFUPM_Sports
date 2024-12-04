import 'package:flutter/material.dart';
import 'package:kfupm_sports/core/theme/app_colors.dart';
import 'package:kfupm_sports/features/main_page/presentation/views/add_event_view.dart';

class MainPageView extends StatelessWidget {
  const MainPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navigationBar,
        title: const Text(
          "My Matches",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddEventView();
              },
            ),
          );
        },
      ),
    );
  }
}
