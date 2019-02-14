import 'dart:async';
import 'package:geolocator/geolocator.dart';
import '../models/geopoint.dart';

Future<GeoPoint> getGeoPoint(
    {String name,
    bool withAddress: false,
    locationAccuracy: LocationAccuracy.best,
    verbose: false}) async {
  /// get a geopoint from Geoplocator
  /// [name] the geopoint identifier
  /// [withAddress] add the address information
  /// [locationAccuracy] the desired accuracy for the geopoint
  /// [verbose] print info
  name = name ?? "Current position";
  GeoPoint geoPoint;
  Position position =
      await Geolocator().getCurrentPosition(desiredAccuracy: locationAccuracy);
  print("POS $position");
  if (withAddress == true) {
    List<Placemark> placemarks = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    geoPoint = GeoPoint(name: name, position: position, placemark: placemark);
    if (verbose == true) {
      print(geoPoint.toString());
    }
  } else {
    geoPoint = GeoPoint(name: name, position: position);
  }
  return geoPoint;
}
