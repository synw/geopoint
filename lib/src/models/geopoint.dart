import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:slugify2/slugify.dart';

Slugify slugify = new Slugify();

class GeoPoint {
  GeoPoint(
      {@required this.name,
      this.id,
      @required this.position,
      this.placemark,
      this.images})
      : assert(name != null),
        assert(position != null) {
    this.slug = slugify.slugify(name);
    this.timestamp = position.timestamp.millisecondsSinceEpoch;
    this.latitude = position.latitude;
    this.longitude = position.longitude;
    this.altitude = position.altitude;
    this.speed = position.speed;
    this.accuracy = position.accuracy;
    this.speedAccuracy = position.speedAccuracy;
    this.heading = position.heading;
    if (placemark != null) {
      this.number = placemark.subThoroughfare;
      this.street = placemark.thoroughfare;
      this.locality = placemark.locality;
      this.locality = placemark.subLocality;
      this.postalCode = placemark.postalCode;
      //this.subregion = placemark.subAdministratieArea;
      this.region = placemark.administrativeArea;
      this.country = placemark.country;
    }
  }

  final String name;
  String slug;
  int id;
  int timestamp;
  Position position;
  Placemark placemark;
  double latitude;
  double longitude;
  double altitude;
  double speed;
  double accuracy;
  double speedAccuracy;
  double heading;
  String number;
  String street;
  String locality;
  String sublocality;
  String postalCode;
  String subregion;
  String region;
  String country;
  List<File> images;

  get address => _getAddress();
  get point => LatLng(latitude, longitude);

  /// build this geopoint from json data
  GeoPoint.fromJson(Map<String, dynamic> json)
      : id = int.tryParse("${json["id"]}"),
        name = json["name"],
        slug = slugify.slugify(json["name"]),
        timestamp = int.tryParse("${json["timestamp"]}"),
        latitude = double.tryParse("${json["latitude"]}"),
        longitude = double.tryParse("${json["longitude"]}"),
        altitude = double.tryParse("${json["altitude"]}"),
        speed = double.tryParse("${json["speed"]}"),
        accuracy = double.tryParse("${json["accuracy"]}"),
        speedAccuracy = double.tryParse("${json["speed_accuracy"]}"),
        heading = double.tryParse("${json["heading"]}"),
        number = json["number"],
        street = json["street"],
        locality = json["locality"],
        sublocality = json["sublocality"],
        postalCode = json["postal_code"],
        subregion = json["subregion"],
        region = json["region"],
        country = json["country"];

  /// [json] the json data to build from

  /// get a GeoPoint from LatLng coordinates
  GeoPoint.fromLatLng({@required String name, @required LatLng point})
      : name = name,
        latitude = point.latitude,
        longitude = point.longitude;

  /// get a json map from this geopoint
  Map<String, String> toStringsMap({bool withId = true}) {
    /// [withId] include the id of the geopoint or not
    Map<String, String> json = {
      "name": "$name",
      "timestamp": "$timestamp",
      "latitude": "$latitude",
      "longitude": "$longitude",
      "altitude": "$altitude",
      "speed": "$speed",
      "heading": "$heading",
      "accuracy": "$accuracy",
      "speed_accuracy": "$speedAccuracy",
      "number": "$number",
      "street": "$street",
      "locality": "$locality",
      "sublocality": "$sublocality",
      "postal_code": "$postalCode",
      "subregion": "$subregion",
      "region": "$region",
      "country": "$country",
    };
    if (withId) json["id"] = "$id";
    return json;
  }

  /// convert this geopoint to string
  @override
  String toString() {
    String str = "Geopoint: $name\n";
    str += "Lat: $latitude\n";
    str += "Lon: $longitude\n";
    str += "Altitude: $altitude\n";
    str += "Speed: $speed\n";
    str += "Heading: $heading\n";
    if (placemark != null) {
      str += _getAddress();
    }
    return str;
  }

  /// A method to get a [GeoPoint] from
  /// the device's current position
  static Future<GeoPoint> getPosition(
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
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: locationAccuracy);
    if (withAddress == true) {
      List<Placemark> placemarks = await Geolocator()
          .placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark placemark = placemarks[0];
      geoPoint = GeoPoint(name: name, position: position, placemark: placemark);
      if (verbose) {
        print(geoPoint.toString());
      }
    } else {
      geoPoint = GeoPoint(name: name, position: position);
    }
    return geoPoint;
  }

  /// get a formated address from this geopoint
  String _getAddress() {
    String address = "$number $street $locality ";
    address += "$postalCode $subregion $region $country";
    return address;
  }
}
