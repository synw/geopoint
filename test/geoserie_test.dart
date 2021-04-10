import "package:test/test.dart";
import 'package:geopoint/geopoint.dart';
import 'package:latlong2/latlong.dart';

void main() {
  final geoPoints = <GeoPoint>[
    GeoPoint(latitude: 0.0, longitude: 0.0),
    GeoPoint(latitude: 1.0, longitude: 1.0),
  ];
  final centroid = GeoPoint(latitude: 0.0, longitude: 0.0);
  final boundary = GeoSerie(
      name: "gs_boundary", geoPoints: geoPoints, type: GeoSerieType.group);
  final geoSerie = GeoSerie(
      id: 1,
      name: "gs",
      geoPoints: geoPoints,
      type: GeoSerieType.polygon,
      centroid: centroid,
      surface: 0.0,
      boundary: boundary);

  test("geoserie", () {
    expect(geoSerie.id, equals(1));
    expect(geoSerie.name, equals("gs"));
    expect(geoSerie.geoPoints, equals(geoPoints));
    expect(geoSerie.type, equals(GeoSerieType.polygon));
    expect(geoSerie.centroid, equals(centroid));
    expect(geoSerie.surface, equals(0.0));
    expect(geoSerie.boundary, equals(boundary));
  });

  test("type", () {
    expect(
        GeoSerie(name: "gs", type: GeoSerieType.line).typeStr, equals("line"));
    expect(GeoSerie(name: "gs", type: GeoSerieType.group).typeStr,
        equals("group"));
    expect(GeoSerie(name: "gs", type: GeoSerieType.polygon).typeStr,
        equals("polygon"));
  });

  test("map", () {
    final data = <String, dynamic>{
      "name": "gs",
      "type": "polygon",
      "id": 1,
      "surface": 0.0
    };
    final gs = geoSerie.toMap();
    expect(gs, equals(data));
  });

  test("json", () {
    final data = <String, dynamic>{
      "name": "gs",
      "type": "line",
      "id": 1,
      "surface": 0.0
    };
    final gs = GeoSerie.fromJson(data);
    expect(gs.id, equals(1));
    expect(gs.name, equals("gs"));
    expect(gs.type, equals(GeoSerieType.line));
    expect(gs.surface, equals(0.0));
  });

  test("name and type", () {
    var gs = GeoSerie.fromNameAndType(name: "gs", typeStr: "line");
    expect(gs.type, GeoSerieType.line);
    gs = GeoSerie.fromNameAndType(name: "gs", typeStr: "polygon");
    expect(gs.type, GeoSerieType.polygon);
    gs = GeoSerie.fromNameAndType(name: "gs", typeStr: "group");
    expect(gs.type, GeoSerieType.group);
    expect(() => GeoSerie.fromNameAndType(name: "gs", typeStr: null),
        throwsA(predicate<dynamic>((dynamic e) => e is AssertionError)));
  });

  test("latlng", () {
    expect(<LatLng>[LatLng(0.0, 0.0), LatLng(1.0, 1.0)], geoSerie.toLatLng());
  });

  test("geojson", () {
    final gs =
        GeoSerie(name: "gs", type: GeoSerieType.group, geoPoints: <GeoPoint>[
      GeoPoint(latitude: 0.0, longitude: 0.0),
      GeoPoint(latitude: 1.0, longitude: 1.0),
    ]);
    const res = "[[0.0,0.0],[1.0,1.0]]";
    expect(gs.toGeoJsonCoordinatesString(), res);
    var str = '{"type":"Feature","properties":{"name":"gs"},'
            '"geometry":{"type":"MultiPoint",'
            '"coordinates":' +
        gs.toGeoJsonCoordinatesString() +
        '}}';
    expect(gs.toGeoJsonFeatureString(null), str);
    gs.type = GeoSerieType.line;
    str = '{"type":"Feature","properties":{"name":"gs"},'
            '"geometry":{"type":"LineString",'
            '"coordinates":' +
        gs.toGeoJsonCoordinatesString() +
        '}}';
    expect(gs.toGeoJsonFeatureString(null), str);
    gs.type = GeoSerieType.polygon;
    str = '{"type":"Feature","properties":{"name":"gs"},'
            '"geometry":{"type":"Polygon",'
            '"coordinates":[' +
        gs.toGeoJsonCoordinatesString() +
        ']}}';
    expect(gs.toGeoJsonFeatureString(null), str);
  });
}
