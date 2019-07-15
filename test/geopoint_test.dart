import "package:test/test.dart";
import 'package:geopoint/geopoint.dart';
import 'package:latlong/latlong.dart';

void main() {
  int ts = DateTime.now().millisecondsSinceEpoch;
  var geoPoint = GeoPoint(
      id: 1,
      name: "gp",
      latitude: 0.0,
      longitude: 0.0,
      timestamp: ts,
      altitude: 0.0,
      speed: 0.0,
      accuracy: 0.0,
      speedAccuracy: 0.0,
      heading: 0.0,
      country: "country",
      locality: "locality",
      sublocality: "sublocality",
      number: "number",
      postalCode: "postalCode",
      region: "region",
      street: "street",
      subregion: "subregion");
  test("constructor", () {
    expect(geoPoint.latitude, equals(0.0));
    expect(geoPoint.longitude, equals(0.0));
    expect(geoPoint.timestamp, equals(ts));
    expect(geoPoint.speed, equals(0.0));
    expect(geoPoint.accuracy, equals(0.0));
    expect(geoPoint.speedAccuracy, equals(0.0));
    expect(geoPoint.altitude, equals(0.0));
    expect(geoPoint.heading, equals(0.0));
    expect(geoPoint.name, equals("gp"));
    expect(geoPoint.slug, equals("gp"));
    expect(geoPoint.point, equals(LatLng(0.0, 0.0)));
    String str = "Geopoint: ${geoPoint.name}\n";
    str += "Lat: ${geoPoint.latitude}\n";
    str += "Lon: ${geoPoint.longitude}\n";
    str += "Altitude: ${geoPoint.altitude}\n";
    str += "Speed: ${geoPoint.speed}\n";
    str += "Heading: ${geoPoint.heading}\n";
    expect(geoPoint.toString(), equals(str));
  });

  test("from json", () {
    Map<String, dynamic> data = <String, dynamic>{
      "id": 1,
      "name": "gp",
      "latitude": 0.0,
      "longitude": 0.0,
      "timestamp": ts,
      "altitude": 0.0,
      "speed": 0.0,
      "accuracy": 0.0,
      "speed_accuracy": 0.0,
      "heading": 0.0,
      "country": "country",
      "locality": "locality",
      "sublocality": "sublocality",
      "number": "number",
      "postalCode": "postalCode",
      "region": "region",
      "street": "street",
      "subregion": "subregion"
    };
    GeoPoint gp = GeoPoint.fromJson(data);
    expect(geoPoint.latitude, equals(gp.latitude));
    expect(geoPoint.longitude, equals(gp.longitude));
    expect(geoPoint.timestamp, equals(gp.timestamp));
    expect(geoPoint.speed, equals(gp.speed));
    expect(geoPoint.accuracy, equals(gp.accuracy));
    expect(geoPoint.speedAccuracy, equals(gp.speedAccuracy));
    expect(geoPoint.altitude, equals(gp.altitude));
    expect(geoPoint.heading, equals(gp.heading));
    expect(geoPoint.name, equals(gp.name));
    expect(geoPoint.slug, equals(gp.slug));
    expect(geoPoint.point, equals(gp.point));
  });

  test("map", () {
    final m = <String, dynamic>{
      "name": geoPoint.name,
      "timestamp": geoPoint.timestamp,
      "latitude": geoPoint.latitude,
      "longitude": geoPoint.longitude,
      "altitude": geoPoint.altitude,
      "speed": geoPoint.speed,
      "heading": geoPoint.heading,
      "accuracy": geoPoint.accuracy,
      "speed_accuracy": geoPoint.speedAccuracy,
      "number": geoPoint.number,
      "street": geoPoint.street,
      "locality": geoPoint.locality,
      "sublocality": geoPoint.sublocality,
      "postal_code": geoPoint.postalCode,
      "subregion": geoPoint.subregion,
      "region": geoPoint.region,
      "country": geoPoint.country,
      "id": geoPoint.id,
    };
    expect(geoPoint.toMap(), equals(m));
  });

  test("null", () {
    expect(() => GeoPoint(latitude: null, longitude: 0.0),
        throwsA(predicate<dynamic>((dynamic e) => e is AssertionError)));
    expect(() => GeoPoint(latitude: 0.0, longitude: null),
        throwsA(predicate<dynamic>((dynamic e) => e is AssertionError)));
  });

  test("from latlng", () {
    var geoPoint = GeoPoint.fromLatLng(name: "gp", point: LatLng(0.0, 0.0));
    expect(geoPoint.latitude, equals(0.0));
    expect(geoPoint.longitude, equals(0.0));
  });

  test("address", () {
    expect(geoPoint.country, equals("country"));
    expect(geoPoint.region, equals("region"));
    expect(geoPoint.subregion, equals("subregion"));
    expect(geoPoint.locality, equals("locality"));
    expect(geoPoint.sublocality, equals("sublocality"));
    expect(geoPoint.postalCode, equals("postalCode"));
    expect(geoPoint.number, equals("number"));
    String address =
        "${geoPoint.number} ${geoPoint.street} ${geoPoint.locality} ";
    address += "${geoPoint.postalCode} ${geoPoint.subregion}" +
        " ${geoPoint.region} ${geoPoint.country}";
    expect(geoPoint.address, equals(address));
  });
}
