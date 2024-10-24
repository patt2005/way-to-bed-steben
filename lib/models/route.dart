import 'package:way_to_bed_steben/models/route_point.dart';

class Route {
  final List<RoutePoint> routePoints;
  String notes;
  String imageFilePath;

  Route({
    required this.routePoints,
    this.notes = "",
    this.imageFilePath = "",
  });
}
