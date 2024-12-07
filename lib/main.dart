import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kfupm_sports/features/main_page/presentation/views/page_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kfupm_sports/providers/general_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  //Init Firebase instance
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const KFUPMSportsApp());
}

class KFUPMSportsApp extends StatelessWidget {
  const KFUPMSportsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return GeneralProvider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: false,
            primarySwatch: Colors.green,
            scaffoldBackgroundColor: Colors.white),
        home: const PagesView(),
      ),
    );
  }
}
