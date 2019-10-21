# Geopoint

[![pub package](https://img.shields.io/pub/v/geopoint.svg)](https://pub.dartlang.org/packages/geopoint) [![Build Status](https://travis-ci.org/synw/geopoint.svg?branch=master)](https://travis-ci.org/synw/geopoint) [![Coverage Status](https://coveralls.io/repos/github/synw/geopoint/badge.svg?branch=master)](https://coveralls.io/github/synw/geopoint?branch=master)

Geospatial data structures for Dart

## Models

### GeoPoint

Datastructure:

   ```dart
   String name;
   final double latitude; // required
   final double longitude; // required
   String slug;
   int timestamp;
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
   ```

Extra constructors:

   ```dart
   /// from a [LatLng]
   GeoPoint.fromLatLng(name: "Position", point: LatLng(51.0,0.0));

   /// from json
   GeoPoint.fromJson(jsonData);
   ```

Methods and getters:

   ```dart
   /// get the formated address
   String address = geoPoint.address;

   /// get the [LatLng] point
   LatLng point = geoPoint.point;

   /// convert to json
   Map<String, dynamic> json = geoPoint.toMap();

   /// convert to a map of strings
   Map<String, String> strMap = geoPoint.toStringsMap();
   ```

### GeoSerie

Datastructure:

   ```dart
   String name;
   int id;
   GeoSerieType type;  /// one of [GeoSerieType.group]
                       /// [GeoSerieType.line] or
                       /// [GeoSerieType.polygon]
   List<GeoPoint> geoPoints;
   num surface;
   GeoSerie boundary;
   GeoPoint centroid;
   ```

Extra constructors:

   ```dart
   /// from json
   GeoSerie geoSerie = GeoSerie.fromJson(jsonData);

   /// from strings
   GeoSerie geoSerie = GeoSerie.fromNameAndType(
       name: "A polygon",
       type: GeoSerieType.polygon,
       // or typeStr: "polygon"
   );
   ```

Methods and getters:

   ```dart
   // convert to json
   Map<String, dynamic> jsonData = geoSerie.toMap();

   /// convert to a list of [LatLng]
   List<LatLng> points = geoSerie.toLatLng(ignoreErrors = true);
   /// The invalid points will be skipped if ignoreErrors is true

   // get the type as a string
   String type = geoSerie.typeStr;
   ```

## Geojson serialization

Serializers are available to get geojson feature or coordinates strings:

```dart
   /// Convert to a geojson feature string
   String feature = geoSerie.toGeoJsonFeatureString();

   /// Convert to a geojson coordinates string
   String coordinates = geoSerie.toGeoJsonCoordinatesString();

   /// Convert to a geojson feature string
   String feature = geoPoint.toGeoJsonFeatureString();

   /// Convert to a geojson coordinates string
   String coordinates = geoPoint.toGeoJsonCoordinatesString();
   ```

## Related packages

- [Geojson](https://github.com/synw/geojson) : to work with geojson data
- [Geopoint location](https://github.com/synw/geopoint_location) a Flutter plugin to handle real time position updates
- [Geopoint sql](https://github.com/synw/geopoint_sql) a Flutter plugin to handle database operations
