import 'dart:async';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class PositionStream {
  PositionStream({this.distanceFilter: 0, this.timeInterval: 3}) {
    init();
  }

  final int distanceFilter;
  final int timeInterval;
  LocationOptions _locationOptions;

  Stream<Position> _positionStream;

  get stream => _positionStream;

  init() {
    // init location stream from distance filter or time interval
    (distanceFilter > 0)
        ? _locationOptions = LocationOptions(
            accuracy: LocationAccuracy.best, distanceFilter: distanceFilter)
        : _locationOptions = LocationOptions(
            accuracy: LocationAccuracy.best,
            timeInterval: (timeInterval * 1000));
    try {
      _positionStream =
          Geolocator().getPositionStream(_locationOptions).asBroadcastStream();
    } catch (e) {
      throw (e.message);
    }
  }
}
