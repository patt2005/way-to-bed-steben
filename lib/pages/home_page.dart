import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:way_to_bed_steben/pages/create_route_page.dart';
import 'package:way_to_bed_steben/utils/app_provider.dart';
import 'package:way_to_bed_steben/utils/route_card.dart';
import 'package:way_to_bed_steben/utils/utils.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final String data = "Hello, world";
  final int number = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Consumer<AppProvider>(
                builder: (context, value, child) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    value.currentUser == null
                        ? "Hello, dear user!"
                        : "Hello, dear ${value.currentUser!.name}!",
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: "Bayon",
                      color: ktext,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
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
                            "Put dots on the map and explore the \ncity along a predetermined route",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontFamily: "Helvetica Neue",
                            ),
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
                            final provider = Provider.of<AppProvider>(context,
                                listen: false);
                            if (provider.currentUser != null) {
                              await Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) => const CreateRoutePage(),
                                ),
                              );
                            } else {
                              await showCupertinoDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CupertinoAlertDialog(
                                    title: const Text('Create a Profile'),
                                    content: const Text(
                                      'Please create a profile in the profile section before adding a new route.',
                                    ),
                                    actions: [
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Routes",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "HelveticaNeue",
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.015),
              Consumer<AppProvider>(
                builder: (context, value, child) {
                  if (value.userRoutes.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "You don't have any routes yet.",
                        style: TextStyle(
                          color: Colors.black38,
                          fontFamily: "HelveticaNeue",
                          fontSize: 16,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: value.userRoutes.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: RouteCard(
                            mapRoute: value.userRoutes[index],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
              SizedBox(height: screenSize.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
