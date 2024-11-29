import 'package:flutter/material.dart';
import 'package:kfupm_sports/features/main_page/presentation/views/page_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  //Init Firebase instance
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const KFUPMSportsApp());
}

class KFUPMSportsApp extends StatelessWidget {
  const KFUPMSportsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const PagesView(),
    );
  }
}
