import 'package:flutter/foundation.dart';

class GeoSerie {
  GeoSerie({@required this.name, @required this.serieType, this.id})
      : assert(name != null),
        assert(serieType != null);

  String name;
  int id;
  String serieType;

  GeoSerie.fromJson(Map<String, dynamic> json)

      /// build this geoserie from json data
      /// [json] the json data to build from
      : name = json["name"],
        id = json["id"],
        serieType = json["type"];

  GeoSerie.fromNameAndSerieType(
      {@required String name, @required String serieType, int id})
      : name = name,
        serieType = serieType,
        id = id;

  Map<String, String> toMap({bool withId: true}) {
    /// get a json map from this serie
    Map<String, String> json = {
      "name": "$name",
      "type": "$serieType",
    };
    if (withId) {
      json["id"] = "${this.id}";
    }
    return json;
  }
}
