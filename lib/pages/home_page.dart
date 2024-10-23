import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:way_to_bed_steben/pages/create_route_page.dart';
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
                height: size.height * 0.22,
                child: Stack(
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      child: Column(
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
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: ElevatedButton(
                          onPressed: () async {
                            await Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) => const CreateRoutePage(),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(kbuton),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          child: Text(
                            "Create a route",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Helvetica Neue",
                              color: ktext2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        "images/point.png",
                        width: screenSize.width * 0.25,
                        height: screenSize.width * 0.25,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenSize.height * 0.03),
              const Text(
                "Routes",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "HelveticaNeue",
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenSize.height * 0.01),
              const Text(
                "You don't have any routes yet.",
                style: TextStyle(
                  color: Colors.black38,
                  fontFamily: "HelveticaNeue",
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}