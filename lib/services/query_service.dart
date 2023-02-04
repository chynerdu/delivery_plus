import 'package:deliveryplus/services/appState.dart';
import 'package:deliveryplus/services/http_instance.dart';
import 'package:deliveryplus/services/localDB.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../models/routeModel.dart';

class QueryService {
  final _service = HttpInstance.instance;

  Future<Map<String, dynamic>> getTimeEstimate(slat, slong, elat, elong) async {
    Controller c = Get.put(Controller());
    try {
      c.change(true);
      String key = dotenv.env['GOOGLEAPIKEY'] as String;
      String url =
          'https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=$slat,$slong&destinations=$elat,$elong&key=$key&travelMode=DRIVING';
      final result = await _service.getData(path: url);
      print('result $result');
      Map<String, dynamic> data = {
        "distance": result['rows'][0]['elements'][0]['distance']['value'],
        "time": result['rows'][0]['elements'][0]['duration']['text']
      };
      c.change(false);
      return data;
    } catch (e) {
      c.change(false);
      rethrow;
    }
  }

  Future<bool> saveSearch(SearchRoute data) async {
    Controller c = Get.put(Controller());
    try {
      final db = await SqliteService.initializeDB();

      await db.insert(
        'routes',
        data.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      getRoutes();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SearchRoute>> getRoutes() async {
    Controller c = Get.put(Controller());
    try {
      c.change(true);
      final db = await SqliteService.initializeDB();
      final List<Map<String, Object?>> queryResult = await db.query(
        'routes',
        orderBy: "id DESC",
      );

      List<SearchRoute> items =
          queryResult.map((e) => SearchRoute.fromMap(e)).toList();
      c.setLocalRoutes(items);
      c.change(false);
      print('saved searched got >>>> $items');
      return items;
    } catch (e) {
      c.change(false);
      rethrow;
    }
  }

  Future<bool> deleteAllRoutes() async {
    Controller c = Get.put(Controller());
    try {
      SqliteService.deleteDB();
      // initializeDB();
      // await db.delete(
      //   'routes',
      // );

      List<SearchRoute> items = [];

      c.setLocalRoutes(items);
      print('deleted');
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
