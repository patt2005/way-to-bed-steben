import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Color kBackGround = const Color(0xFF4848FF);
Color kbuton = const Color(0xffFFD700);
Color ktext = const Color(0xff000000);
Color ktext2 = const Color(0xff111112);

late Size screenSize;

const String mapBoxApiKey =
    "pk.eyJ1IjoicGF0dDIwNSIsImEiOiJjbTJsdHgzeTUwZnlpMmpxeTFrbDJ3cDV3In0.jWTR9njFUzbFwTJUb9QZlw";

Future<CameraPosition?> getUserLocation() async {
  LocationPermission permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.whileInUse ||
      permission == LocationPermission.always) {
    Position currentPosition = await Geolocator.getCurrentPosition();
    return CameraPosition(
      target: LatLng(currentPosition.latitude, currentPosition.longitude),
    );
  }
  return null;
}
