import 'package:flutter/material.dart';
import 'package:way_to_bed_steben/pages/profile.dart';
import 'package:way_to_bed_steben/pages/profile.edit.dart';
import 'package:way_to_bed_steben/utils/utils.dart';
import 'package:way_to_bed_steben/pages/navigation_page.dart';

class Profilefill extends StatefulWidget {
  const Profilefill({super.key});

  @override
  State<Profilefill> createState() => _ProfilefillState();
}

class _ProfilefillState extends State<Profilefill> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Profile",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: "Helvetica Neue",
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => (const Profileedit()),
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
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: size.width * 0.3,
              height: size.width * 0.3,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("images/image 162.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Text("Tony, 26"),
            const Text("tony@gmail.com"),
            const SizedBox(
              height: 20,
            ),
            for (int i = 0; i < 2; i++) ...[
              Container(
                width: double.infinity,
                height: size.height * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kcontainer10,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
            const SizedBox(
              height: 230,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Terms of Use",
                  style: TextStyle(
                    fontSize: 12,
                    color: ktext3,
                    fontFamily: "Helvetica Neue",
                  ),
                ),
                Text(
                  "Developer Website",
                  style: TextStyle(
                    fontSize: 12,
                    color: ktext3,
                    fontFamily: "Helvetica Neue",
                  ),
                ),
                Text(
                  "Privacy Policy",
                  style: TextStyle(
                    fontSize: 12,
                    color: ktext3,
                    fontFamily: "Helvetica Neue",
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
