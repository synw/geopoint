import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sqlcool/sqlcool.dart';
import '../models/geopoint.dart';

saveGeoPoint(
    {@required String name,
    @required Db database,
    GeoPoint geopoint,
    bool withAddress: false,
    verbose: false}) async {
  /// get a geopoint and record it into the database
  /// [name] the geopoint identifier
  /// [database] the Db to save into
  /// [withAddress] add the address information
  /// [verbose] print info
  GeoPoint gp;
  (geopoint == null)
      ? gp = await getGeoPoint(
          name: name, withAddress: withAddress, verbose: verbose)
      : gp = geopoint;
  if (verbose) {
    print("GEOPOINT $gp");
  }
  await gp.save(database: database, verbose: verbose).catchError((e) {
    throw (e);
  });
}

Future<GeoPoint> getGeoPoint(
    {@required String name,
    bool withAddress: false,
    locationAccuracy: LocationAccuracy.best,
    verbose: false}) async {
  /// get a geopoint from Geoplocator
  /// [name] the geopoint identifier
  /// [withAddress] add the address information
  /// [locationAccuracy] the desired accuracy for the geopoint
  /// [verbose] print info
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
