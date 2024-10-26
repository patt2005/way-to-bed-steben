import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:way_to_bed_steben/models/user_profile.dart';
import 'package:way_to_bed_steben/utils/app_provider.dart';
import 'package:way_to_bed_steben/utils/utils.dart';
import '../models/route_containers.dart';
import 'package:path/path.dart' as path;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<TextEditingController> _controllers =
      List.generate(3, (index) => TextEditingController());

  String? _profileImagePath;

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
    final provider = Provider.of<AppProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: provider.userProfileList.isEmpty
            ? null
            : IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  CupertinoIcons.back,
                  color: Colors.black,
                ),
              ),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          "Profile",
          style: TextStyle(
            fontSize: 17,
            fontFamily: "Helvetica Neue",
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    final imagePicker = ImagePicker();
                    final image = await imagePicker.pickImage(
                        source: ImageSource.gallery);
                    if (image != null) {
                      final cacheDir = await getTemporaryDirectory();
                      final timestamp =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      final filePath = path.join(
                          cacheDir.path, 'profile_picture_$timestamp.png');
                      final newFile = File(filePath);

                      if (await newFile.exists()) {
                        await newFile.delete();
                      }

                      await File(image.path).copy(filePath);
                      setState(() {
                        _profileImagePath = filePath;
                      });
                    }
                  },
                  child: _profileImagePath != null
                      ? Container(
                          width: size.height * 0.1,
                          height: size.height * 0.1,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(size.height * 0.05),
                          ),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(size.height * 0.05),
                            child: Image(
                              fit: BoxFit.cover,
                              image: FileImage(File(_profileImagePath!)),
                            ),
                          ),
                        )
                      : Container(
                          width: size.height * 0.1,
                          height: size.height * 0.1,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("images/Frame 30.png"),
                            ),
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
                            TextField(
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              controller: _controllers[0],
                              decoration: InputDecoration(
                                hintText: routeContainers[0].fieldText,
                                filled: true,
                                fillColor: kcontainer1,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              controller: _controllers[1],
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                hintText: routeContainers[1].fieldText,
                                filled: true,
                                fillColor: kcontainer1,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: _controllers[2],
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                hintText: routeContainers[2].fieldText,
                                filled: true,
                                fillColor: kcontainer1,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
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
                    const SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        for (var controller in _controllers) {
                          if (controller.text.isEmpty ||
                              _profileImagePath == null) {
                            return;
                          }
                        }

                        final provider =
                            Provider.of<AppProvider>(context, listen: false);
                        var user = UserProfile(
                          name: _controllers[0].text,
                          age: int.parse(_controllers[1].text),
                          email: _controllers[2].text,
                          imageFilePath: _profileImagePath!,
                        );
                        if (provider.userProfileList.isNotEmpty) {
                          Navigator.of(context).pop();
                        }
                        provider.addUserProfile(user);
                        provider.setCurrentUser(user);
                      },
                      child: Center(
                        child: Container(
                          width: size.width * 0.2,
                          height: size.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: kbuton,
                          ),
                          child: Center(
                            child: Text(
                              "Save",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Helvetica Neue",
                                color: ktext2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.1),
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
