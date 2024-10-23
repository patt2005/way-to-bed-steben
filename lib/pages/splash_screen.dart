import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:way_to_bed_steben/pages/navigation_page.dart';
import 'package:way_to_bed_steben/utils/utils.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const NavigationPage()),
      );
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGround,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Way to\n Bad \n Steben",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Bayon",
                fontSize: 80,
                color: Colors.white,
              ),
            ),
            SizedBox(height: screenSize.height * 0.03),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
