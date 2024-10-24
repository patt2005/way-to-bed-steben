import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:way_to_bed_steben/models/route_point.dart';

class OpenRouteApi {
  static const String openRouteServiceToken =
      "5b3ce3597851110001cf624820cabfa7b863436d8e77699410fbf3ba";

  final Dio _dio = Dio();

  Future<String> getGeometryString(List<RoutePoint> routePoins) async {
    final coordinates = routePoins
        .map((point) => [point.latLng.longitude, point.latLng.latitude])
        .toList();

    const url = 'https://api.openrouteservice.org/v2/directions/driving-car';
    final headers = {
      "Accept":
          "application/json, application/geo+json, application/gpx+xml, img/png; charset=utf-8",
      "Authorization": openRouteServiceToken,
      "Content-Type": "application/json; charset=utf-8",
    };

    try {
      final response = await _dio.post(
        url,
        options: Options(headers: headers),
        data: {
          "coordinates": coordinates,
        },
      );

      debugPrint(response.data.toString());

      if (response.statusCode == 200) {
        final data = response.data;
        final geometry = data['routes'][0]['geometry'];

        return geometry;
      }
    } catch (e) {
      debugPrint('Error fetching route: $e');
    }
    return "";
  }
}
