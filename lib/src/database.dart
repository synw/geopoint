import 'package:flutter/foundation.dart';
import 'package:sqlcool/sqlcool.dart';

initGeoDb(
    {@required String dbpath, @required Db database, verbose = false}) async {
  /// initialize a geo database
  /// [dbpath] is the path to the database file
  /// relative to the documents directory
  /// [database] is the database to use, defaults to the
  /// default Sqlcool database
  /// [verbose] print the query
  String q2 = """CREATE TABLE geopoint (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    latitude REAL NOT NULL,
    longitude REAL NOT NULL,
    timestamp INTEGER NOT NULL,
    speed REAL,
    altitude REAL,
    heading REAL,
    accuracy REAL,
    speed_accuracy REAL,
    number VARCHAR(60),
    street VARCHAR(60),
    locality VARCHAR(60),
    sublocality VARCHAR(60),
    postal_code VARCHAR(60),
    subregion VARCHAR(60),
    region VARCHAR(60),
    country VARCHAR(60),
    geoserie INTEGER NOT NULL,
    FOREIGN KEY (geoserie) REFERENCES geoserie(id) ON DELETE CASCADE)""";
  String q = """CREATE TABLE geoserie (
    id INTEGER PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    type check(type = "marker" or type = "line" or type="polygon") DEFAULT "marker")""";
  await database
      .init(path: dbpath, queries: <String>[q, q2], verbose: verbose)
      .catchError((e) {
    throw (e);
  });
}
