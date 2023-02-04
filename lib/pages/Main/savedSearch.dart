import 'package:deliveryplus/helpers/commom/customLoader.dart';
import 'package:deliveryplus/helpers/theme/customColors.dart';
import 'package:deliveryplus/models/routeModel.dart';
import 'package:deliveryplus/pages/Main/start.dart';
import 'package:deliveryplus/services/appState.dart';
import 'package:deliveryplus/services/query_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SavedSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SavedSearchState();
  }
}

class SavedSearchState extends State<SavedSearch> {
  QueryService queryService = QueryService();
  CustomLoader customLoader = CustomLoader();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getSavedSearch();
    });

    super.initState();
  }

  getSavedSearch() async {
    try {
      await queryService.getRoutes();
    } catch (e) {
      customLoader.showError(e);
    }
  }

  deleteAllSearch() async {
    try {
      await queryService.deleteAllRoutes();
    } catch (e) {
      customLoader.showError(e);
    }
  }

  goToMap(startLatitude, startLongitude, endLatitude, endLongtitude, startText,
      endText, weight) {
    LatLng startPosition = LatLng(startLatitude, startLongitude);
    LatLng endPosition = LatLng(endLatitude, endLongtitude);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => Start(
                isSaved: true,
                startPosition: startPosition,
                endPosition: endPosition,
                startLocation: startText,
                destinationLocation: endText,
                weight: weight))));
  }

  Widget build(BuildContext context) {
    Controller c = Get.put(Controller());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Showing all saved searches'),
          actions: [
            GestureDetector(
                onTap: (() => deleteAllSearch()),
                child: const Icon(
                  Icons.delete_forever,
                  size: 30,
                  color: CustomColors.PrimaryColor,
                ))
          ],
        ),
        body: c.localRoutes.isEmpty
            ? const Center(child: Text('You have not saved any search'))
            : Obx(() {
                return Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListView.builder(
                      itemCount: c.localRoutes.length,
                      itemBuilder: ((context, index) {
                        SearchRoute route = c.localRoutes[index];
                        return ListTile(
                          onTap: () => {
                            goToMap(
                                double.tryParse(route.startLatitude.toString()),
                                double.tryParse(
                                    route.startLongitude.toString()),
                                double.tryParse(route.endLatitude.toString()),
                                double.tryParse(route.endLongitude.toString()),
                                route.startLocationText,
                                route.endLocationText,
                                route.weight.toString())
                          },
                          dense: true,
                          isThreeLine: true,
                          title: Text('From: ${route.startLocationText}'),
                          subtitle: Text('To: ${route.endLocationText}'),
                          trailing: Text('${route.weight}KG',
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black)),
                        );
                      }),
                    ));
              }));
  }
}
