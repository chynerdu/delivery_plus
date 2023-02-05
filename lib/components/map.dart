import 'dart:math';
import 'dart:typed_data';

import 'package:deliveryplus/components/SWbutton.dart';
import 'package:deliveryplus/helpers/commom/customLoader.dart';
import 'package:deliveryplus/helpers/commom/geolocation.dart';
import 'package:deliveryplus/helpers/theme/customColors.dart';
import 'package:deliveryplus/models/routeModel.dart';
import 'package:deliveryplus/services/query_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart' as poly;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import 'dart:ui' as ui;

class CustomMap extends StatefulWidget {
  LatLng startLocation;
  LatLng endLocation;
  String startLocationText;
  String destinationLocationText;
  String weight;
  bool? isSaved;
  CustomMap(
      {super.key,
      required this.startLocation,
      required this.endLocation,
      required this.startLocationText,
      required this.destinationLocationText,
      required this.isSaved,
      required this.weight});
  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  String googleApikey = dotenv.env['GOOGLEAPIKEY'] as String;
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  GeolocationHelper geolocationHelper = GeolocationHelper();
  QueryService queryService = QueryService();
  dynamic _placeDistance;
  bool isSaved = false;
  String _timeEstimate = 'Calculating..';
  CustomLoader customLoader = CustomLoader();
  String location = "Search Location";
  Position position = Position(
      heading: 0.0,
      latitude: 0.00,
      longitude: 0.00,
      accuracy: 0.0,
      altitude: 0.0,
      timestamp: DateTime.now(),
      speedAccuracy: 0.0,
      speed: 0.0);

  double southWestLatitude = 0.0;
  double southWestLongitude = 0.0;

  double northEastLatitude = 0.0;
  double northEastLongitude = 0.0;

  // Object for PolylinePoints
  late poly.PolylinePoints polylinePoints;
// List of coordinates to join
  List<LatLng> polylineCoordinates = [];

// Map storing polylines created by connecting two points
  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isSaved = widget.isSaved ?? false;
      getEstimate();
      _createPolylines(
          widget.startLocation.latitude,
          widget.startLocation.longitude,
          widget.endLocation.latitude,
          widget.endLocation.longitude);
      // LatLng.startLocation = widget.startLocation ?? LatLng(0.00, 0.00);
      getCurrentLocation();
    });

    print('start location ${widget.startLocation}');

    print('start location ${widget.endLocation}');

    super.initState();
  }

  getEstimate() async {
    try {
      var result = await queryService.getTimeEstimate(
          widget.startLocation.latitude.toString(),
          widget.startLocation.longitude.toString(),
          widget.endLocation.latitude.toString(),
          widget.endLocation.longitude.toString());

      setState(() {
        _placeDistance = (int.tryParse(result['distance'].toString())! / 1000);
        _timeEstimate = result['time'];
      });
    } catch (e) {
      customLoader.showError('Something is not right, please try again');
      customLoader.dismissLoader();
    }
  }

  saveSearch() async {
    try {
      SearchRoute searchRoute = SearchRoute(
          startLatitude: widget.startLocation.latitude.toString(),
          startLongitude: widget.startLocation.longitude.toString(),
          endLatitude: widget.endLocation.latitude.toString(),
          startLocationText: widget.startLocationText,
          endLocationText: widget.destinationLocationText,
          endLongitude: widget.endLocation.longitude.toString(),
          weight: int.tryParse(widget.weight.toString()));
      customLoader.showLoader('Saving to device...');
      await queryService.saveSearch(searchRoute);
      setState(() {
        isSaved = true;
      });
      customLoader
          .showSuccess('Saved succesfully, you can view it on saved search...');
    } catch (e) {
      print(e);
      customLoader.dismissLoader();
    }
  }

  // Create the polylines for showing the route between two places

  _createPolylines(
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    // Initializing PolylinePoints
    polylinePoints = poly.PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    poly.PolylineResult result =
        await polylinePoints.getRouteBetweenCoordinates(
      dotenv.env['GOOGLEAPIKEY'] as String, // Google Maps API Key
      poly.PointLatLng(startLatitude, startLongitude),
      poly.PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: poly.TravelMode.transit,
    );

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      print('length of points>>>>>>>>> ${result.points.length}');
      result.points.forEach((poly.PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    // Defining an ID
    PolylineId id = const PolylineId('poly');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );

    // Adding the polyline to the map
    polylines[id] = polyline;

// between small segments
    double totalDistance = 0.0;
    for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += _coordinateDistance(
        polylineCoordinates[i].latitude,
        polylineCoordinates[i].longitude,
        polylineCoordinates[i + 1].latitude,
        polylineCoordinates[i + 1].longitude,
      );
    }

    setState(() {});

    // setState(() {
    //   _placeDistance = totalDistance.toStringAsFixed(2);
    // });
  }

  // Actual distance
  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  adjustMarkerView() {
    double miny = (widget.startLocation.latitude <= widget.endLocation.latitude)
        ? widget.startLocation.latitude
        : widget.endLocation.latitude;
    double minx =
        (widget.startLocation.longitude <= widget.endLocation.longitude)
            ? widget.startLocation.longitude
            : widget.endLocation.longitude;
    double maxy = (widget.startLocation.latitude <= widget.endLocation.latitude)
        ? widget.endLocation.latitude
        : widget.startLocation.latitude;
    double maxx =
        (widget.startLocation.longitude <= widget.endLocation.longitude)
            ? widget.endLocation.longitude
            : widget.startLocation.longitude;

    southWestLatitude = miny;
    southWestLongitude = minx;

    northEastLatitude = maxy;
    northEastLongitude = maxx;
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);

    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);

    ui.FrameInfo fi = await codec.getNextFrame();

    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  String getCost() {
    double cost = 0;
    if (_placeDistance != null) {
      double weight = double.tryParse(widget.weight.toString()) as double;
      double distance = double.tryParse(_placeDistance.toString()) as double;
      cost = weight * distance;
    } else {
      cost = 0;
    }
    return cost.toStringAsFixed(2);
  }

  getCurrentLocation() async {
    // position = await geolocationHelper.determinePosition();
    adjustMarkerView();
    setState(() {
      // widget.startLocation = LatLng(position.latitude, position.longitude);
      mapController?.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          100.0,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      GoogleMap(
        myLocationEnabled: true,
        polylines: Set<Polyline>.of(polylines.values),
        // zoomControlsEnabled: false,
        //Map widget from google_maps_flutter package
        zoomGesturesEnabled: true, //enable Zoom in, out on map
        scrollGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
          //innital position in map
          target: widget.startLocation, //initial position
          zoom: 14.0,
          //initial zoom level
        ),
        mapType: MapType.normal, //map type
        onMapCreated: (controller) {
          //method called when map is created
          setState(() {
            mapController = controller;
          });
        },
        markers: <Marker>{
          Marker(
            onTap: () async {
              print('Tapped');
            },
            icon: BitmapDescriptor.defaultMarker,
            draggable: false,
            markerId: MarkerId('${position.latitude}'),
            position: LatLng(position.latitude, position.longitude),
            // onDragStart: (value) => print('dragginf >>>>>>>>>'),
          ),

          // end marker
          Marker(
            draggable: false,
            markerId: MarkerId('${position.latitude}'),
            position: LatLng(
                widget.endLocation.latitude, widget.endLocation.longitude),
          )
        },
        onCameraMove: (CameraPosition cameraPositiona) {
          cameraPosition = cameraPositiona;
        },
        onCameraIdle: () async {
          if (cameraPosition != null) {
            List<Placemark> placemarks = await placemarkFromCoordinates(
                cameraPosition!.target.latitude,
                cameraPosition!.target.longitude);
            setState(() {
              location =
                  "${placemarks.first.street}, ${placemarks.first.administrativeArea}";

              position = Position(
                  longitude: cameraPosition!.target.longitude,
                  latitude: cameraPosition!.target.latitude,
                  timestamp: DateTime.now(),
                  accuracy: 0.0,
                  altitude: 0.0,
                  heading: 0.0,
                  speed: 0.0,
                  speedAccuracy: 0.0);
            });
          }
        },
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.25),
      ),
      const Center(
          //picker image on google map
          child: Icon(Icons.pin_drop)),
      Positioned(
          top: 50,
          left: 10,
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back, size: 30))),
      Positioned(
        bottom: 0,
        child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
            ),
            child: Container(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    ListTile(
                      title:
                          const Text('From:', style: TextStyle(fontSize: 13)),
                      subtitle: Text('${widget.startLocationText}',
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                    ),
                    ListTile(
                        title:
                            const Text('To:', style: TextStyle(fontSize: 13)),
                        subtitle: Text('${widget.destinationLocationText}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black87)),
                        trailing: Visibility(
                          visible: _placeDistance == null ? false : true,
                          child: Text(
                            '$_placeDistance km',
                            style: const TextStyle(
                              color: CustomColors.PrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                    ListTile(
                      title: const Text('Weight of Package',
                          style: TextStyle(fontSize: 13)),
                      subtitle: Text('${widget.weight}KG',
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87)),
                    ),
                    ListTile(
                      title: const Text(
                          'Total Cost (at \$1 per KM and weight) and Time Estimate',
                          style: TextStyle(fontSize: 13)),
                      subtitle: Text(
                        '\$${getCost()}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: CustomColors.PrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        '$_timeEstimate',
                        style: const TextStyle(
                          fontSize: 16,
                          color: CustomColors.PrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Visibility(
                        visible: !isSaved ? true : false,
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: SWbutton(
                              title: 'Save this search',
                              onPressed: () async {
                                saveSearch();
                              },
                            )))
                  ],
                ))),
      )
    ]));
  }
}
