import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:way_to_bed_steben/pages/profile.dart';
import 'package:way_to_bed_steben/pages/profile.edit.dart';
import 'package:way_to_bed_steben/utils/app_provider.dart';
import 'package:way_to_bed_steben/utils/utils.dart';

class Profilefill extends StatefulWidget {
  const Profilefill({super.key});

  @override
  State<Profilefill> createState() => _ProfilefillState();
}

class _ProfilefillState extends State<Profilefill> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<AppProvider>(
      builder: (context, value, child) => value.currentUser == null
          ? const Profile()
          : Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  "Profile",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: "Helvetica Neue",
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Profileedit(),
                        ),
                      );
                    },
                    child: const Text(
                      "Edit",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: "Helvetica Neue",
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                ],
              ),
              body: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      width: size.width * 0.3,
                      height: size.width * 0.3,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(
                            File(value.currentUser!.imageFilePath),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "${value.currentUser!.name}, ${value.currentUser!.age}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 27,
                      ),
                    ),
                    Text(value.currentUser!.email),
                    const SizedBox(
                      height: 20,
                    ),
                    for (int i = 0; i < value.userProfileList.length; i++) ...[
                      GestureDetector(
                        onTap: () {
                          value.setCurrentUser(value.userProfileList[i]);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          width: double.infinity,
                          height: size.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kcontainer10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                CupertinoIcons.circle_fill,
                                color: value.userProfileList[i] ==
                                        value.currentUser
                                    ? Colors.green
                                    : Colors.black,
                              ),
                              const SizedBox(width: 7),
                              Text(value.userProfileList[i].name),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                    GestureDetector(
                      onTap: () async {
                        await Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => const Profile(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        width: double.infinity,
                        height: size.height * 0.05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kcontainer10,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              CupertinoIcons.add,
                              color: Colors.black,
                            ),
                            SizedBox(width: 7),
                            Text("Create account"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await launchUrl(Uri.parse("https://google.com/"));
                          },
                          child: Text(
                            "Terms of Use",
                            style: TextStyle(
                              fontSize: 12,
                              color: ktext3,
                              fontFamily: "Helvetica Neue",
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await launchUrl(Uri.parse("https://google.com/"));
                          },
                          child: Text(
                            "Developer Website",
                            style: TextStyle(
                              fontSize: 12,
                              color: ktext3,
                              fontFamily: "Helvetica Neue",
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await launchUrl(Uri.parse("https://google.com/"));
                          },
                          child: Text(
                            "Privacy Policy",
                            style: TextStyle(
                              fontSize: 12,
                              color: ktext3,
                              fontFamily: "Helvetica Neue",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
            ),
    );
  }
}
