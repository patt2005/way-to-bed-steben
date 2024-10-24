import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:way_to_bed_steben/models/route.dart';

class RouteDetailsPage extends StatefulWidget {
  final MapRoute mapRoute;

  const RouteDetailsPage({super.key, required this.mapRoute});

  @override
  State<RouteDetailsPage> createState() => _RouteDetailsPageState();
}

class _RouteDetailsPageState extends State<RouteDetailsPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _setMarkersAndPolylines();
  }

  Future<void> _showConfirmMarkAsCompletedDialog(int index) async {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Mark as Completed'),
          content: const Text('Do you want to mark this point as completed?'),
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
                  widget.mapRoute.routePoints[index].isCompleted = true;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _setMarkersAndPolylines() async {
    _markers.clear();

    for (var i = 0; i < widget.mapRoute.routePoints.length; i++) {
      var point = widget.mapRoute.routePoints[i];
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: point.latLng,
          infoWindow: InfoWindow(
            title: point.name,
          ),
          icon: point.isCompleted
              ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
              : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }

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
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: GoogleMap(
              myLocationButtonEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              initialCameraPosition: CameraPosition(
                target: widget.mapRoute.routePoints.first.latLng,
                zoom: 14.0,
              ),
              markers: _markers,
              polylines: widget.mapRoute.polylines,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Route Points',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  for (var i = 0; i < widget.mapRoute.routePoints.length; i++)
                    ListTile(
                      onTap: () {
                        if (!widget.mapRoute.routePoints[i].isCompleted) {
                          _showConfirmMarkAsCompletedDialog(i);
                        }
                      },
                      leading: Icon(
                        Icons.location_pin,
                        color: widget.mapRoute.routePoints[i].isCompleted
                            ? Colors.green
                            : Colors.red,
                      ),
                      title: Text(widget.mapRoute.routePoints[i].name),
                      subtitle: Text(
                        widget.mapRoute.routePoints[i].isCompleted
                            ? 'Completed'
                            : 'Pending',
                        style: TextStyle(
                          color: widget.mapRoute.routePoints[i].isCompleted
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      trailing: widget.mapRoute.routePoints[i].isCompleted
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.radio_button_unchecked,
                              color: Colors.red,
                            ),
                    ),
                  const SizedBox(height: 16),
                  const Text(
                    'Notes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.mapRoute.notes,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (widget.mapRoute.imageFilePaths.isNotEmpty) ...[
                    const Text(
                      'Images',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.mapRoute.imageFilePaths.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(widget.mapRoute.imageFilePaths[index]),
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
