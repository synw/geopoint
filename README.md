# Geopoint

[![pub package](https://img.shields.io/pub/v/geopoint.svg)](https://pub.dartlang.org/packages/geopoint)

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
   Map<String, String> json = geoPoint.toMap();
   ```

### GeoSerie

Datastructure:

   ```dart
   final String name; // required
   final int id;
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
   Map<String, String> jsonData = geoSerie.toMap();

   // get the type as a string
   String type = geoSerie.typeStr;
   ```