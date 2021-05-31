import 'dart:convert';

import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';
import 'geopoint.dart';

/// The type of the geoserie: group of points, line or polygon
enum GeoSerieType {
  /// A group of geopoints
  group,

  /// A group of geopoints forming a line
  line,

  /// A group of geopoints forming a polygon
  polygon,
}

/// A class to hold information about a serie of [GeoPoint]
class GeoSerie {
  /// Default constructor: requires a [name] and a [type]
  GeoSerie(
      {this.name,
      this.type,
      this.id,
      this.geoPoints,
      this.surface,
      this.boundary,
      this.centroid});

  /// Name if the geoserie
  String name;

  /// Id of the geoserie
  int id;

  /// Type of the geoserie
  GeoSerieType type;

  /// The list of [GeoPoint] in the serie
  List<GeoPoint> geoPoints;

  /// The surface of a geometry
  num surface;

  /// Boundaries of a geometry
  GeoSerie boundary;

  /// The centroid of a geometry
  GeoPoint centroid;

  /// The type of the serie as a string
  String get typeStr => _typeToString();

  /// Make a [GeoSerie] from json data
  GeoSerie.fromJson(Map<String, dynamic> json)
      : name = "${json["name"]}",
        id = int.parse("${json["id"]}"),
        surface = double.tryParse("${json["surface"]}") {
    type = _typeFromString("${json["type"]}");
  }

  /// Make a [GeoSerie] from name and serie type
  GeoSerie.fromNameAndType(
      {@required this.name, @required String typeStr, this.id})
      : assert(typeStr != null) {
    type = _typeFromString(typeStr);
  }

  /// [name] the name of the [GeoSerie]
  /// [typeStr] the type of the serie: group, line or polygon
  /// [id] the id of the serie

  /// Get a json map from this [GeoSerie]
  Map<String, dynamic> toMap({bool withId = true}) {
    /// [withId] include the id in the result
    final json = <String, dynamic>{
      "name": name,
      "type": "${_typeToString(type)}",
      "surface": surface
    };
    if (withId) {
      json["id"] = id;
    }
    return json;
  }

  /// Get a list of [LatLng] from this [GeoSerie]
  List<LatLng> toLatLng({bool ignoreErrors = false}) {
    final points = <LatLng>[];
    for (final geoPoint in geoPoints) {
      try {
        points.add(geoPoint.point);
      } catch (_) {
        if (!ignoreErrors) {
          rethrow;
        }
      }
    }
    return points;
  }

  /// Convert to a geojson coordinates string
  String toGeoJsonCoordinatesString() {
    final coords = <String>[];
    for (final geoPoint in geoPoints) {
      coords.add(geoPoint.toGeoJsonCoordinatesString());
    }
    return "[" + coords.join(",") + "]";
  }

  /// Convert to a geojson feature string
  String toGeoJsonFeatureString(Map properties) =>
      _toGeoJsonFeatureString(properties);

  String _toGeoJsonFeatureString(Map properties) {
    String featType;
    switch (type) {
      case GeoSerieType.group:
        featType = "MultiPoint";
        break;
      case GeoSerieType.line:
        featType = "LineString";
        break;
      case GeoSerieType.polygon:
        featType = "Polygon";
    }
    return _buildGeoJsonFeature(
        featType, properties ?? <String, dynamic>{"name": name});
  }

  String _buildGeoJsonFeature(String type, Map properties) {
    var extra1 = "";
    var extra2 = "";
    if (type == "Polygon") {
      extra1 = "[";
      extra2 = "]";
    }
    return '{"type":"Feature","properties":${jsonEncode(properties)},'
            '"geometry":{"type":"$type",'
            '"coordinates":' +
        extra1 +
        toGeoJsonCoordinatesString() +
        extra2 +
        '}}';
  }

  GeoSerieType _typeFromString(String typeStr) {
    GeoSerieType res;
    switch (typeStr) {
      case "group":
        res = GeoSerieType.group;
        break;
      case "line":
        res = GeoSerieType.line;
        break;
      case "polygon":
        res = GeoSerieType.polygon;
    }
    return res;
  }

  String _typeToString([GeoSerieType st]) {
    GeoSerieType t;
    (st != null) ? t = st : t = type;
    String res;
    switch (t) {
      case GeoSerieType.group:
        res = "group";
        break;
      case GeoSerieType.line:
        res = "line";
        break;
      case GeoSerieType.polygon:
        res = "polygon";
    }
    return res;
  }
}
