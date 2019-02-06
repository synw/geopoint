import 'package:flutter/foundation.dart';
import 'package:sqlcool/sqlcool.dart';

class GeoSerie {
  GeoSerie({this.name, this.serieType});

  String name;
  String serieType;

  Map<String, String> toMap() {
    /// get a json map from this serie
    Map<String, String> json = {
      "name": "$name",
      "type": "$serieType",
    };
    return json;
  }

  save({@required Db database, bool verbose = false}) async {
    /// save a serie into a database
    /// [database] is the database to use
    /// [verbose] print query info
    if (verbose) {
      print("SAVING the ${this.name} ${this.serieType} serie");
    }
    Map<String, String> row = toMap();
    try {
      await database
          .insert(table: "serie", row: row, verbose: verbose)
          .catchError((e) {
        throw (e);
      });
    } catch (e) {
      throw (e);
    }
  }
}
