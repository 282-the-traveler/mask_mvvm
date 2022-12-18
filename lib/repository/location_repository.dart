import 'package:geolocator/geolocator.dart';

class LocationRepository {
  Future getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }
}
