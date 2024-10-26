import 'package:flutter/material.dart';
import 'route.dart';

class RouteEvent {
  final DateTime date;
  final List<MapRoute> routes;
  final Color activityColor;
  String notes = "";

  RouteEvent({
    required this.date,
    required this.routes,
    required this.activityColor,
  });
}
