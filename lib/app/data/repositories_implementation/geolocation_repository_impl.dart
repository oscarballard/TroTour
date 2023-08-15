import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:google_maps_webservice';

import '../../domain/repositories/geolocation_repository.dart';

class GeoLocationRepositoryImpl implements GeoLocationRepository {
  @override
  Future<LatLng> get geoLocation async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return LatLng(position.latitude, position.longitude);
  }

  void lookFor(){
    // final places = GoogleMapsPlaces(apiKey: 'YOUR_GOOGLE_PLACES_API_KEY');

  }
}
