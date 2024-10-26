import 'package:flutter/material.dart';
import 'package:way_to_bed_steben/models/route.dart';
import 'package:way_to_bed_steben/models/route_event.dart';
import 'package:way_to_bed_steben/models/user_profile.dart';
import 'package:way_to_bed_steben/utils/utils.dart';

class AppProvider extends ChangeNotifier {
  final List<UserProfile> _userProfileList = [];
  List<UserProfile> get userProfileList => _userProfileList;

  UserProfile? _currentUser;
  UserProfile? get currentUser => _currentUser;

  final List<MapRoute> _mapRoutesList = [];
  final List<RouteEvent> _events = [];

  void setCurrentUser(UserProfile user) {
    _currentUser = user;
    notifyListeners();
  }

  void updateUserProfile(UserProfile profileInfo) {
    _currentUser!.age = profileInfo.age;
    _currentUser!.name = profileInfo.name;
    _currentUser!.email = profileInfo.email;
    _currentUser!.imageFilePath = profileInfo.imageFilePath;
    notifyListeners();
  }

  void addUserProfile(UserProfile userProfile) {
    _userProfileList.add(userProfile);
    _currentUser ??= userProfile; // Set the first user as the current user
    notifyListeners();
  }

  // Get routes specific to the current user
  List<MapRoute> get userRoutes {
    if (_currentUser == null) return [];
    return _mapRoutesList
        .where((route) => route.userId == _currentUser!.name)
        .toList();
  }

  // Get events specific to the current user
  List<RouteEvent> get userEvents {
    if (_currentUser == null) return [];
    return _events
        .where((event) => event.userId == _currentUser!.name)
        .toList();
  }

  // Get marked dates for the current user
  List<DateTime> get markedDates {
    return userEvents
        .map((event) => normalizeDate(event.date))
        .toSet()
        .toList();
  }

  // Add route with user association
  void addRoute(MapRoute mapRoute) {
    _mapRoutesList.add(mapRoute);
    notifyListeners();
  }

  // Add event with user association
  void addEvent(RouteEvent event) {
    _events.add(event);
    notifyListeners();
  }

  // Get routes for a specific date for the current user
  List<MapRoute> getRoutesForDate(DateTime date) {
    return userEvents
        .where((event) => normalizeDate(event.date) == normalizeDate(date))
        .expand((event) => event.routes)
        .toList();
  }

  // Update notes for a specific date
  void updateNotesForDate(DateTime date, String notes) {
    final event = userEvents.firstWhere(
      (e) => normalizeDate(e.date) == normalizeDate(date),
      orElse: () => throw Exception('Event not found'),
    );
    event.notes = notes;
    notifyListeners();
  }

  // Remove route from an event on a specific date
  void removeRouteFromEvent(DateTime date, MapRoute route) {
    final event = userEvents.firstWhere(
      (e) => normalizeDate(e.date) == normalizeDate(date),
      orElse: () => throw Exception('Event not found'),
    );
    event.routes.remove(route);
    notifyListeners();
  }

  // Mark route point as completed
  void markPointAsCompleted(MapRoute route, int index) {
    route.routePoints[index].isCompleted = true;
    notifyListeners();
  }
}
