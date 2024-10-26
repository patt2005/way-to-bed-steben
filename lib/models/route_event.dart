import 'package:flutter/material.dart';
import 'route.dart';

class RouteEvent {
  final DateTime date;
  final List<MapRoute> routes;
  final Color activityColor;
  String notes = "";
  final String userId;

  RouteEvent({
    required this.date,
    required this.routes,
    required this.activityColor,
    required this.userId,
  });
}
