import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:way_to_bed_steben/utils/open_route_api.dart';

Color kBackGround = const Color(0xFF4848FF);
Color kbuton = const Color(0xffFFD700);
Color ktext = const Color(0xff000000);
Color ktext2 = const Color(0xff111112);

late Size screenSize;

final OpenRouteApi openROuteApi = OpenRouteApi();

Future<CameraPosition?> getUserLocation() async {
  LocationPermission permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.whileInUse ||
      permission == LocationPermission.always) {
    Position currentPosition = await Geolocator.getCurrentPosition();
    return CameraPosition(
      zoom: 14,
      target: LatLng(currentPosition.latitude, currentPosition.longitude),
    );
  }
  return null;
}

List<LatLng> decodePolyline(String encoded) {
  List<LatLng> polyline = [];
  int index = 0, len = encoded.length;
  int lat = 0, lng = 0;

  while (index < len) {
    int shift = 0, result = 0;
    int b;
    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    lat += dlat;

    shift = 0;
    result = 0;
    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    lng += dlng;

    polyline.add(LatLng(lat / 1E5, lng / 1E5));
  }
  return polyline;
}
