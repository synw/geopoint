import 'dart:io';

import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';
import 'package:slugify2/slugify.dart';

var _slugify = Slugify();

/// A class to hold geopoint data structure
class GeoPoint {
  /// Default constructor: needs [latitude] and [longitude]
  GeoPoint(
      {@required this.latitude,
      @required this.longitude,
      this.name,
      this.id,
      this.slug,
      this.timestamp,
      this.altitude,
      this.speed,
      this.accuracy,
      this.heading,
      this.country,
      this.locality,
      this.sublocality,
      this.number,
      this.postalCode,
      this.region,
      this.speedAccuracy,
      this.street,
      this.subregion,
      this.images})
      : assert(latitude != null),
        assert(longitude != null) {
    if (slug == null && name != null) slug = _slugify.slugify(name);
  }

  /// The name of the geopoint
  String name;

  /// A latitude coordinate
  final double latitude;

  /// A longitude coordinate
  final double longitude;

  /// A string without spaces nor special characters. Can be used
  /// to define file paths
  String slug;

  /// The id of the geopoint
  int id;

  /// The timestamp
  int timestamp;

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
        country = "${json["country"]}" {
    if (slug == null && name != null) {
      slug = _slugify.slugify("${json["name"]}");
    }
  }

  /// Get a GeoPoint from [LatLng] coordinates
  ///
  /// [name] is the name of this [GeoPoint] and
  /// [point] is a [LatLng] coordinate
  GeoPoint.fromLatLng({@required LatLng point, this.name})
      : latitude = point.latitude,
        longitude = point.longitude {
    if (name != null) slug = _slugify.slugify(name);
  }

  /// Get a json map from this geopoint
  ///
  /// [withId] include the id of the geopoint or not
  Map<String, dynamic> toMap({bool withId = true}) {
    final json = <String, dynamic>{
      "name": name,
      "timestamp": timestamp,
      "latitude": latitude,
      "longitude": longitude,
      "altitude": altitude,
      "speed": speed,
      "heading": heading,
      "accuracy": accuracy,
      "speed_accuracy": speedAccuracy,
      "number": number,
      "street": street,
      "locality": locality,
      "sublocality": sublocality,
      "postal_code": postalCode,
      "subregion": subregion,
      "region": region,
      "country": country,
    };
    if (withId) json["id"] = id;
    return json;
  }

  /// Get a strings map from this geopoint
  ///
  /// [withId] include the id of the geopoint or not
  Map<String, String> toStringsMap({bool withId = true}) {
    final json = <String, String>{
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

  /// Convert this [GeoPoint] to a [LatLng] object
  LatLng toLatLng({bool ignoreErrors = false}) {
    LatLng latLng;
    try {
      latLng = LatLng(latitude, longitude);
    } catch (e) {
      if (!ignoreErrors) {
        rethrow;
      }
    }
    return latLng;
  }

  /// Convert to a geojson feature string
  String toGeoJsonFeatureString() => _toGeoJsonFeatureString("Point");

  String _toGeoJsonFeatureString(String type) {
    return '{"type":"Feature","properties":{"name":"$name"},'
            '"geometry":{"type":"$type",'
            '"coordinates":' +
        toGeoJsonCoordinatesString() +
        '}}';
  }

  /// Convert to a geojson coordinates string
  String toGeoJsonCoordinatesString() {
    return '[$longitude,$latitude]';
  }

  /// Get a formated address from this geopoint
  String _getAddress() {
    return "$number $street $locality "
        "$postalCode $subregion $region $country";
  }

  /// Convert this geopoint to string
  @override
  String toString() {
    String n;
    if (name != null) {
      n = name;
    } else {
      n = "$latitude/$longitude";
    }
    return "Geopoint $n";
  }

  /// Convert this geopoint to detailled string
  String details() {
    var str = "Geopoint: $name\n";
    str += "Lat: $latitude\n";
    str += "Lon: $longitude\n";
    str += "Altitude: $altitude\n";
    str += "Speed: $speed\n";
    str += "Heading: $heading\n";
    return str;
  }
}
