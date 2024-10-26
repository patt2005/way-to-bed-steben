import 'package:flutter/material.dart';
import 'package:way_to_bed_steben/models/route.dart';
import 'package:way_to_bed_steben/models/route_event.dart';
import 'package:way_to_bed_steben/utils/utils.dart';

class AppProvider extends ChangeNotifier {
  final List<MapRoute> _mapRoutesList = [];

  List<MapRoute> get mapRoutesList => _mapRoutesList;

  final List<RouteEvent> _events = [];

  List<RouteEvent> get events => _events;

  void addEvent(RouteEvent event) {
    _events.add(event);
    notifyListeners();
  }

  void removeRouteFromEvent(DateTime date, MapRoute route) {
    final event =
        _events.firstWhere((e) => normalizeDate(e.date) == normalizeDate(date));
    event.routes.remove(route);
    notifyListeners();
  }

  List<MapRoute> getRoutesForDate(DateTime date) {
    return _events
        .where((event) => normalizeDate(event.date) == normalizeDate(date))
        .expand((event) => event.routes)
        .toList();
  }

  List<DateTime> get markedDates {
    return _events.map((event) => normalizeDate(event.date)).toSet().toList();
  }

  void addRoute(MapRoute mapRoute) {
    _mapRoutesList.add(mapRoute);
    notifyListeners();
  }

  void updateNotesForDate(DateTime date, String notes) {
    final event =
        _events.firstWhere((e) => normalizeDate(e.date) == normalizeDate(date));
    event.notes = notes;
    notifyListeners();
  }

  void markPointAsCompleted(MapRoute route, int index) {
    route.routePoints[index].isCompleted = true;
    notifyListeners();
  }
}
