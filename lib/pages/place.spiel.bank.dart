import 'package:flutter/material.dart';

class Placespielbank extends StatefulWidget {
  const Placespielbank({super.key});

  @override
  State<Placespielbank> createState() => _PlacespielbankState();
}

class _PlacespielbankState extends State<Placespielbank> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Spielbank Bad Steben",
            style: TextStyle(
              fontSize: 30,
              fontFamily: "Bayon",
              color: Colors.black,
            ),
          )
        ],
      )),
    );
  }
}
