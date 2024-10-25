import 'package:flutter/material.dart';
import 'package:way_to_bed_steben/utils/utils.dart';
import '../models/route_containers.dart';
import 'route_containers.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<TextEditingController> _controllers =
      List.generate(3, (index) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: "Helvetica Neue",
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  width: size.width * 0.2,
                  height: size.height * 0.125,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("images/Frame 30.png"),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kcontainer,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Information",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: "Helvetica Neue",
                              ),
                            ),
                            const SizedBox(height: 20),
                            for (int i = 0; i < 3; i++) ...[
                              TextField(
                                controller: _controllers[i],
                                decoration: InputDecoration(
                                  hintText: routeContainers[i].fieldText,
                                  filled: true,
                                  fillColor: kcontainer1,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              if (i < 2) const SizedBox(height: 20),
                            ],
                            const SizedBox(height: 20),
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
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
