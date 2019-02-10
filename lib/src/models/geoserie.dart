import 'package:flutter/foundation.dart';
import 'package:sqlcool/sqlcool.dart';

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

  Map<String, String> toMap({bool withId: false}) {
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

  // crud methods

  save({@required Db database, bool verbose = false}) async {
    /// save this serie into a database
    /// [database] is the database to use
    /// [verbose] print query info
    if (verbose) {
      print("SAVING the ${this.name} ${this.serieType} serie");
    }
    Map<String, String> row = this.toMap();
    try {
      await database
          .insert(table: "geoserie", row: row, verbose: verbose)
          .catchError((e) {
        throw (e);
      });
    } catch (e) {
      throw (e);
    }
  }

  update({@required database, bool verbose = false}) async {
    /// save this serie into a database
    /// [database] is the database to use
    /// [verbose] print query info
    if (verbose) {
      print("Updating the ${this.name} ${this.serieType} serie");
    }
    await database
        .update(
            table: "geoserie",
            row: this.toMap(),
            where: "id=${this.id}",
            verbose: verbose)
        .catchError((e) {
      throw (e);
    });
  }

  delete({@required database, bool verbose = false}) async {
    /// delete this serie from a database
    /// [database] is the database to use
    /// [verbose] print query info
    if (verbose) {
      print("Deleting the ${this.name} ${this.serieType} serie");
    }
    await database
        .delete(table: "geoserie", where: "id=${this.id}", verbose: verbose)
        .catchError((e) {
      throw (e);
    });
  }
}
