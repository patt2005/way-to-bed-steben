import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:way_to_bed_steben/pages/splash_screen.dart';
import 'package:way_to_bed_steben/utils/app_provider.dart';
import 'package:way_to_bed_steben/utils/utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      title: 'Flutter Splash screen demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const Splashscreen(),
    );
  }
}
