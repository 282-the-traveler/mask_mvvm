import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/store.dart';

class StoreRepository {
  Future<List<Store>> fetch(double lat, double lng) async {
    final List<Store> storeList = [];

    try {
      var uri = Uri.https('gist.githubusercontent.com',
          '/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json');

      var response = await http.get(uri);
      final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));

      final jsonStores = jsonResult['stores'];
      jsonStores.forEach((jsonStore) {
        storeList.add(Store.fromJson(jsonStore));
      });
      return storeList
          .where(
            (element) =>
                element.remainStat == 'plenty' ||
                element.remainStat == 'some' ||
                element.remainStat == 'few',
          )
          .toList();
    } catch (e) {
      return [];
    }
  }
}
