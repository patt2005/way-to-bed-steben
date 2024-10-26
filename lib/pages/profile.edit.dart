import 'package:flutter/material.dart';
import 'package:way_to_bed_steben/models/route_containers.dart';
import 'package:way_to_bed_steben/pages/profile.fill.dart';
import 'package:way_to_bed_steben/utils/utils.dart';

class Profileedit extends StatefulWidget {
  const Profileedit({super.key});

  @override
  State<Profileedit> createState() => _ProfileeditState();
}

class _ProfileeditState extends State<Profileedit> {
  // Declarația listei de controlere
  final List<TextEditingController> _controllers =
      List.generate(3, (_) => TextEditingController());

  @override
  void dispose() {
    // Asigură-te că eliberezi controlerele
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
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
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Profilefill(),
                            ),
                          );
                        },
                        child: const Text(
                          "Done",
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
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                ],
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
    );
  }
}
