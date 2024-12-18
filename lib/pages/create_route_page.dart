import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:way_to_bed_steben/models/route_point.dart';
import 'package:way_to_bed_steben/pages/create_route_info_page.dart';
import 'package:way_to_bed_steben/utils/utils.dart';

class CreateRoutePage extends StatefulWidget {
  const CreateRoutePage({super.key});

  @override
  State<CreateRoutePage> createState() => _CreateRoutePageState();
}

class _CreateRoutePageState extends State<CreateRoutePage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CameraPosition? _currentPosition;

  final Set<Marker> _markers = {};

  final List<RoutePoint> _routePoints = [];

  final Set<Polyline> _polylines = {};

  final TextEditingController _pointTitleController = TextEditingController();

  bool _isCreatingPoint = false;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _drawRoute() async {
    setState(() {
      _polylines.clear();
    });
    if (_routePoints.length < 2) return;

    try {
      final geometryString = await openROuteApi.getGeometryString(_routePoints);
      final polylinePoints = decodePolyline(geometryString);
      setState(() {
        _polylines.clear();
        _polylines.add(
          Polyline(
            polylineId: const PolylineId('route_path'),
            points: polylinePoints,
            color: Colors.black,
            width: 5,
          ),
        );
      });
    } catch (e) {
      debugPrint('Error fetching route: $e');
    }
  }

  void _showDeleteConfirmationDialog(String markerId) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this point?'),
          actions: [
            CupertinoDialogAction(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Delete'),
              onPressed: () async {
                setState(() {
                  _routePoints.removeWhere((point) =>
                      point.latLng ==
                      _markers
                          .firstWhere((e) => e.markerId.value == markerId)
                          .position);
                  _markers.removeWhere((e) => e.markerId.value == markerId);
                });
                await _drawRoute();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmDoneMarker(int index) async {
    await showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Confirm Mark as Done'),
          content: const Text('Do you want to mark this point as done?'),
          actions: [
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              isDestructiveAction: false,
              child: const Text('Yes'),
              onPressed: () {
                setState(() {
                  _routePoints[index].isCompleted = true;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _addMarker(LatLng position) async {
    final String markerId = _markers.length.toString();
    _markers.add(
      Marker(
        onTap: () {
          setState(() {
            _showDeleteConfirmationDialog(markerId);
          });
        },
        markerId: MarkerId(markerId),
        position: position,
        infoWindow: InfoWindow(
          title: _pointTitleController.text,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
    _routePoints.add(
      RoutePoint(
        latLng: position,
        name: _pointTitleController.text,
        isCompleted: false,
      ),
    );
    _pointTitleController.clear();
    await _drawRoute();
    await showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Success'),
          content: const Text('Route point added successfully!'),
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
    setState(() {});
  }

  void _getUserLocation() async {
    _currentPosition = await getUserLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
        ),
      ),
      body: _currentPosition == null
          ? Center(
              child: CircularProgressIndicator(
                color: kBackGround,
              ),
            )
          : SizedBox(
              width: screenSize.width,
              height: screenSize.height,
              child: Stack(
                children: [
                  SizedBox(
                    height: screenSize.height * 0.5,
                    width: screenSize.width,
                    child: GoogleMap(
                      myLocationButtonEnabled: false,
                      onMapCreated: (GoogleMapController controller) async {
                        _controller.complete(controller);
                      },
                      polylines: _polylines,
                      myLocationEnabled: true,
                      markers: _markers,
                      onTap: (argument) async {
                        if (_isCreatingPoint &&
                            _pointTitleController.text.isNotEmpty) {
                          await _addMarker(argument);
                        } else {
                          showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: const Text('Point Name Required'),
                                content: const Text(
                                    'Please set a point name before creating a route.'),
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
                      mapType: MapType.normal,
                      initialCameraPosition: _currentPosition!,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: screenSize.height * 0.54,
                      width: screenSize.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: screenSize.height * 0.03),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "Make up your own route",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Bayon",
                                fontSize: 28,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.01),
                          if (_isCreatingPoint)
                            Container(
                              margin: EdgeInsets.only(
                                left: 20,
                                right: 20,
                                bottom: screenSize.height * 0.01,
                              ),
                              child: TextField(
                                controller: _pointTitleController,
                                decoration: InputDecoration(
                                  hintText: "Name of point",
                                  hintStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 20,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Colors.blue,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          _routePoints.isEmpty
                              ? const Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "You haven't added any routes so far.",
                                        style: TextStyle(
                                          color: Colors.black38,
                                          fontFamily: "SFPro",
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Expanded(
                                  child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    itemCount: _routePoints.length,
                                    separatorBuilder: (_, __) =>
                                        const Divider(),
                                    itemBuilder: (context, index) {
                                      final point = _routePoints[index];
                                      return ListTile(
                                        leading: const Icon(
                                          CupertinoIcons.placemark,
                                          color: Colors.blue,
                                        ),
                                        trailing: GestureDetector(
                                          onTap: () {
                                            if (!point.isCompleted) {
                                              _confirmDoneMarker(index);
                                            }
                                          },
                                          child: Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                              color: point.isCompleted
                                                  ? Colors.green
                                                  : Colors.grey,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          point.name,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.13),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_routePoints.length < 2 &&
                                    _isCreatingPoint) {
                                  await showCupertinoDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CupertinoAlertDialog(
                                        title: const Text(
                                            'Insufficient Route Points'),
                                        content: const Text(
                                            'Please add at least two points on the map to create a valid route.'),
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
                                  return;
                                }
                                if (_isCreatingPoint &&
                                    _routePoints.length >= 2) {
                                  await Navigator.of(context).push(
                                    CupertinoPageRoute(
                                      builder: (context) => CreateRouteInfoPage(
                                        route: _routePoints,
                                        polylines: _polylines,
                                      ),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    _isCreatingPoint = true;
                                  });
                                }
                              },
                              style: ButtonStyle(
                                padding: const WidgetStatePropertyAll(
                                  EdgeInsets.symmetric(vertical: 13),
                                ),
                                backgroundColor: WidgetStatePropertyAll(kbuton),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _isCreatingPoint
                                        ? "Done"
                                        : "Create a route",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Helvetica Neue",
                                      color: ktext2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.05),
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
