import 'package:google_maps_flutter/google_maps_flutter.dart';

class RoutePoint {
  final LatLng latLng;
  final String name;
  final bool isCompleted;

  RoutePoint({
    required this.latLng,
    required this.name,
    required this.isCompleted,
  });
}
