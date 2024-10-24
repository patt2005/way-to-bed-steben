import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:way_to_bed_steben/models/route.dart';
import 'package:way_to_bed_steben/models/route_point.dart';
import 'package:way_to_bed_steben/utils/app_provider.dart';
import 'package:way_to_bed_steben/utils/utils.dart';

class CreateRouteInfoPage extends StatefulWidget {
  final List<RoutePoint> route;
  final Set<Polyline> polylines;

  const CreateRouteInfoPage({
    super.key,
    required this.route,
    required this.polylines,
  });

  @override
  State<CreateRouteInfoPage> createState() => _CreateRouteInfoPageState();
}

class _CreateRouteInfoPageState extends State<CreateRouteInfoPage> {
  final List<String> _imageFilePaths = [];

  final TextEditingController _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (_notesController.text.isNotEmpty) {
                MapRoute mapRoute = MapRoute(
                  routePoints: widget.route,
                  notes: _notesController.text,
                  imageFilePaths: _imageFilePaths,
                  polylines: widget.polylines,
                );
                final provider =
                    Provider.of<AppProvider>(context, listen: false);
                provider.addMapRoute(mapRoute);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              } else {
                await showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: const Text('Notes Required'),
                      content:
                          const Text('Please enter notes before proceeding.'),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: const Text(
              "Done",
              style: TextStyle(
                color: Color(0xFF0373F3),
                fontFamily: "SFPro",
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 7),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenSize.height * 0.02),
            const Text(
              "Make up your own route",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Bayon",
                fontSize: 28,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: screenSize.height * 0.02),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black38),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _notesController,
                maxLines: 8,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Text',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: "HelveticaNeue",
                  ),
                ),
              ),
            ),
            SizedBox(height: screenSize.height * 0.01),
            const Text(
              "Notes about location",
              style: TextStyle(
                color: Colors.black38,
                fontSize: 15,
              ),
            ),
            SizedBox(height: screenSize.height * 0.03),
            if (_imageFilePaths.isNotEmpty)
              SizedBox(
                height: screenSize.height * 0.1,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _imageFilePaths.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(
                          File(_imageFilePaths[index]),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            SizedBox(height: screenSize.height * 0.02),
            GestureDetector(
              onTap: () async {
                final imagePicker = ImagePicker();
                final image =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  final cacheDir = await getTemporaryDirectory();
                  final uniqueFileName =
                      'profile_picture_${DateTime.now().millisecondsSinceEpoch}.png';
                  final filePath = path.join(cacheDir.path, uniqueFileName);
                  final newFile = File(filePath);

                  if (await newFile.exists()) {
                    await newFile.delete();
                  }

                  await File(image.path).copy(filePath);

                  setState(() {
                    _imageFilePaths.add(filePath);
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.upload,
                      color: Colors.grey,
                      size: 40,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pick out pictures if there are any',
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Manrope",
                            fontSize: 14,
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
      ),
    );
  }
}
