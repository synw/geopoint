import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:slugify2/slugify.dart';

var _slugify = Slugify();

/// A class to hold geopoint data structure
class GeoPoint {
  /// Default constructor: needs a [name] and a [position]
  GeoPoint(
      {@required this.name,
      this.id,
      @required this.position,
      this.placemark,
      this.images})
      : assert(name != null),
        assert(position != null) {
    this.slug = _slugify.slugify(name);
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

  /// The name of the geopoint
  final String name;

  /// A string without spaces nor special characters. Can be used
  /// to define file paths
  String slug;

  /// The id of the geopoint
  int id;

  /// The timestamp
  int timestamp;

  /// The [Position] from Geolocator
  Position position;

  /// The [Placemark] object from Geolocator
  Placemark placemark;

  /// A latitude coordinate
  double latitude;

  /// A longitude coordinate
  double longitude;

  /// The altitude of the geopoint
  double altitude;

  /// The speed
  double speed;

  /// The accuracy of the mesurement
  double accuracy;

  /// The accuracy of the speed
  double speedAccuracy;

  /// The heading
  double heading;

  /// Number in the street
  String number;

  /// Street name
  String street;

  /// Locality name
  String locality;

  /// Sublocality name
  String sublocality;

  /// Local postal code
  String postalCode;

  /// Subregion
  String subregion;

  /// Region
  String region;

  /// Country
  String country;

  /// A list of images can be attached to the geopoint
  List<File> images;

  /// the formated address of the [GeoPoint]
  String get address => _getAddress();

  /// the [LatLng] of the [GeoPoint]
  LatLng get point => LatLng(latitude, longitude);

  /// Build this geopoint from json data
  GeoPoint.fromJson(Map<String, dynamic> json)
      : id = int.tryParse("${json["id"]}"),
        name = "${json["name"]}",
        slug = _slugify.slugify("${json["name"]}"),
        timestamp = int.tryParse("${json["timestamp"]}"),
        latitude = double.tryParse("${json["latitude"]}"),
        longitude = double.tryParse("${json["longitude"]}"),
        altitude = double.tryParse("${json["altitude"]}"),
        speed = double.tryParse("${json["speed"]}"),
        accuracy = double.tryParse("${json["accuracy"]}"),
        speedAccuracy = double.tryParse("${json["speed_accuracy"]}"),
        heading = double.tryParse("${json["heading"]}"),
        number = "${json["number"]}",
        street = "${json["street"]}",
        locality = "${json["locality"]}",
        sublocality = "${json["sublocality"]}",
        postalCode = "${json["postal_code"]}",
        subregion = "${json["subregion"]}",
        region = "${json["region"]}",
        country = "${json["country"]}";

  /// Get a GeoPoint from LatLng coordinates
  GeoPoint.fromLatLng({@required String name, @required LatLng point})
      : name = name,
        latitude = point.latitude,
        longitude = point.longitude;

  /// [name] the name of the [GeoPoint]
  /// [point] the [LatLng] of the [GeoPoint]

  /// Get a json map from this geopoint
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

  /// A method to get a [GeoPoint] from
  /// the device's current position
  static Future<GeoPoint> getPosition(
      {String name,
      bool withAddress = false,
      LocationAccuracy locationAccuracy = LocationAccuracy.best,
      bool verbose = false}) async {
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
}
