// lib/features/main_page/main.dart

import 'package:flutter/material.dart';
import 'package:kfupm_sports/features/main_page/presentation/views/main_page_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MainPageView(),
    );
  }
}
