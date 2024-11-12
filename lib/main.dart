import 'package:flutter/material.dart';
import 'package:kfupm_sports/features/main_page/presentation/views/events_page_view.dart';
import 'package:kfupm_sports/features/main_page/presentation/views/main_page_view.dart';
import 'package:kfupm_sports/features/main_page/presentation/views/profile_page_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Creating the routes for the main pages
      // "/" indicates or refers to the main (home) page
      initialRoute: "/",
      routes: {
        "/": (context) => const MainPageView(),
        "/events_view": (context) => const EventsPageView(),
        "/profile_view": (context) => const ProfilePageView(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}
