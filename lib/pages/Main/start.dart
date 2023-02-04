import 'package:deliveryplus/components/map.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Start extends StatelessWidget {
  LatLng startPosition = LatLng(0.0, 0.0);
  LatLng endPosition = LatLng(0.0, 0.0);
  String startLocation;
  String destinationLocation;
  String weight;
  bool? isSaved;
  Start(
      {super.key,
      required this.startPosition,
      required this.endPosition,
      required this.startLocation,
      required this.destinationLocation,
      this.isSaved,
      required this.weight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomMap(
            isSaved: isSaved,
            startLocation: startPosition,
            endLocation: endPosition,
            weight: weight,
            startLocationText: startLocation,
            destinationLocationText: destinationLocation));
  }
}
