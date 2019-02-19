# Geopoint

Data structures and methods for the [Geolocator](https://github.com/BaseflowIT/flutter-geolocator) Flutter plugin

## Models

### Geopoint

Datastructure:

   ```dart
   final String name; // required
   String slug;
   int timestamp;
   Position position; // from Geolocator
   Placemark placemark; // from Geolocator
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

Constructors:

   ```dart
   // from a position
   var position = await Geolocator().getCurrentPosition(
      desiredAccuracy: locationAccuracy);
   String name = "My location";
   GeoPoint geoPoint = GeoPoint(name: name, position: position);

   // from json
   Map<String, dynamic> json = {
      "name": "Mylocation",
      "latitude": 0.0,
      // ...
      // uses all fields except [position] and [placemark]
   };
   GeoPoint geoPoint = GeoPoint.fromJson(json);
   ```

Methods:

   ```dart
   // get the current location as a GeoPoint
   GeoPoint geoPoint = await getGeoPoint(name: "My location", withAddress: true);
   // get the formated address
   String address = geoPoint.address;

   // convert to json
   Map<String, String> json = geoPoint.toMap();
   ```

## GeoSerie

Datastructure:

   ```dart
   final String name; // required
   final int id;
   final String serieType;  // required
   ```

Constructors:

   ```dart
   // ftom json
   Map<String, dynamic> json = {
       "name": "A polygon",
       "id":1,
       "serieType": "polygon",
   }
   GeoSerie geoSerie = GeoSerie.fromJson(json);

   // from strings
   GeoSerie geoSerie = GeoSerie.fromNameAndSerieType(
       name: "A polygon",
       serieType: "polygon",
   );
   ```

Methods:

   ```dart
   // convert to json
   Map<String, String> json = geoSerie.toMap();
   ```