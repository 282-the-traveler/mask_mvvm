import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../model/store.dart';
import '../repository/location_repository.dart';
import '../repository/store_repository.dart';

class StoreViewModel with ChangeNotifier {
  bool isLoading = false;
  List<Store> storeList = [];
  final _storeRepository = StoreRepository();
  final _locationRepository = LocationRepository();

  StoreViewModel() {
    fetch();
  }

  Future fetch() async {
    isLoading = true;
    notifyListeners();

    Position position = await _locationRepository.getCurrentLocation();
    storeList = await _storeRepository.fetch(
      position.latitude,
      position.longitude,
    );

    isLoading = false;
    notifyListeners();
  }
}
