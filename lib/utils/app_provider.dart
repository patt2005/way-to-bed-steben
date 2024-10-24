import 'package:flutter/material.dart';
import 'package:way_to_bed_steben/models/route.dart';

class AppProvider extends ChangeNotifier {
  final List<MapRoute> _routes = [];
  List<MapRoute> get routes => _routes;

  void addMapRoute(MapRoute mapRoute) {
    _routes.add(mapRoute);
    notifyListeners();
  }

  void markPointAsCompleted(MapRoute route, int index) {
    route.routePoints[index].isCompleted = true;
    notifyListeners();
  }
}
