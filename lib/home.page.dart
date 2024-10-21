import 'package:flutter/material.dart';
import 'package:way_to_bed_steben/utils/utils.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Text(
                "Hello, dear Tony!",
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: "Bayon",
                  color: ktext,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: kBackGround,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.topLeft,
                width: double.infinity,
                height: size.height * 0.25,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Stack(
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Make up your own route",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontFamily: "Helvetica Neue"),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Put dots on the map and explore the \n city along a predetermined route",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontFamily: "Helvetica Neue"),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: kbuton,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          alignment: Alignment.center,
                          width: size.width * 0.26,
                          height: size.height * 0.05,
                          child: Text(
                            "Create a route",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Helvetica Neue",
                                color: ktext2,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
