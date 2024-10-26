import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:way_to_bed_steben/models/route_point.dart';

class MapRoute {
  final List<RoutePoint> routePoints;
  final String notes;
  final List<String> imageFilePaths;
  final Set<Polyline> polylines;
  final String userId;

  MapRoute({
    required this.routePoints,
    required this.notes,
    required this.imageFilePaths,
    required this.polylines,
    required this.userId,
  });
}
