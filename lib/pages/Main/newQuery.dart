import 'package:deliveryplus/components/SWbutton.dart';
import 'package:deliveryplus/components/inputText.dart';
import 'package:deliveryplus/helpers/commom/customLoader.dart';
import 'package:deliveryplus/helpers/commom/geolocation.dart';
import 'package:deliveryplus/helpers/theme/customColors.dart';
import 'package:deliveryplus/pages/Main/start.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class NewQuery extends StatefulWidget {
  const NewQuery({super.key});

  @override
  State<StatefulWidget> createState() {
    return NewQueryState();
  }
}

class NewQueryState extends State<NewQuery> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController weightController = TextEditingController();
  GoogleMapController? mapController; //contrller for Google map
  GeolocationHelper geolocationHelper = GeolocationHelper();
  CustomLoader customLoader = CustomLoader();
  String startLocation = "Start Search Location";
  String destinationLocation = "Search Destination Location";
  LatLng startPosition = const LatLng(0.0, 0.0);

  LatLng endPosition = const LatLng(0.0, 0.0);

  getStartPosition(position, location) {
    startPosition = position;
    startLocation = location;
  }

  getEndPosition(position, location) {
    endPosition = position;
    destinationLocation = location;
  }

  proceed() {
    try {
      if (startPosition.latitude == 0.0 || endPosition.latitude == 0.0) {
        customLoader.showError('Select delivery cordinates');
        return;
      }
      if (!_formKey.currentState!.validate()) {
        return;
      }
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => Start(
                  startPosition: startPosition,
                  endPosition: endPosition,
                  startLocation: startLocation,
                  destinationLocation: destinationLocation,
                  weight: weightController.text))));
      // ignore: empty_catches
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text('New Estimate'),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                width: MediaQuery.of(context).size.width,
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 66),
                        const Text(
                            'Get Delivery Cost and Time Estimate for your Package',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 66),
                        LocationPicker(
                            location: startLocation,
                            getLocation: (position, location) {
                              getStartPosition(position, location);
                            }),
                        const SizedBox(height: 25),
                        LocationPicker(
                            location: destinationLocation,
                            getLocation: (position, location) {
                              getEndPosition(position, location);
                            }),
                        const SizedBox(height: 25),
                        Input(
                          maxLength: 3,
                          controller: weightController,
                          keyboard: KeyboardType.NUMBER,
                          hintText: 'What is the weight of the item (In KG)',
                          prefix: const Icon(Icons.scale_outlined,
                              color: Colors.black54, size: 18),
                          validator: (String? value) {
                            if (value == '') return 'Field cannot be empty';
                          },
                          onSaved: (String? value) {},
                        ),
                        const SizedBox(height: 40),
                        SWbutton(
                          title: 'Get Estimate',
                          onPressed: () {
                            proceed();
                            // Get.to(Tabs());
                            // Get.to(JobDetails());
                          },
                        ),
                      ],
                    )))));
  }
}

class LocationPicker extends StatefulWidget {
  String location;
  Function getLocation;
  LocationPicker(
      {super.key, required this.location, required this.getLocation});

  @override
  State<StatefulWidget> createState() {
    return LocationPickerState();
  }
}

class LocationPickerState extends State<LocationPicker> {
  String googleApikey = dotenv.env['GOOGLEAPIKEY'] as String;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          var place = await PlacesAutocomplete.show(
              hint: 'Search Delivery Entry Point',
              context: context,
              apiKey: googleApikey,
              mode: Mode.overlay,
              types: [],
              strictbounds: false,
              components: [Component(Component.country, 'ng')],
              //google_map_webservice package
              onError: (err) {
                print(err);
              });

          if (place != null) {
            setState(() {
              widget.location = place.description.toString();
            });

            final plist = GoogleMapsPlaces(
              apiKey: googleApikey,
              apiHeaders: await const GoogleApiHeaders().getHeaders(),
            );
            String placeid = place.placeId ?? "0";
            final detail = await plist.getDetailsByPlaceId(placeid);
            final geometry = detail.result.geometry!;
            final lat = geometry.location.lat;
            final lang = geometry.location.lng;
            LatLng position = LatLng(lat, lang);

            widget.getLocation(position, widget.location);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Card(
            child: Container(
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                child: ListTile(
                  leading: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.pin_drop_outlined,
                          size: 18, color: Colors.black54)),
                  title: Text(
                    widget.location,
                    style: const TextStyle(fontSize: 14),
                  ),
                  trailing: const Icon(Icons.search,
                      size: 18, color: CustomColors.PrimaryColor),
                  dense: true,
                )),
          ),
        ));
  }
}
