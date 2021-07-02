# Changelog

## 1.0.0

Null safety support

## 0.8.0

- Update dependencies
- Fix in `GeoSerie` line geojson serialization

## 0.7.1

Fix geojson serialization

## 0.7.0

- Remove some deprecated serialization methods
- Use extra_pedantic for static analysis

## 0.6.1

Provide support for deprecated geojson serializers

## 0.6.0

- Make the name and type parameters optional in `GeoSerie` constructor
- Improve the toString method for `GeoPoint`
- Rename the geojson serializers

## 0.5.0

- Add the `toLatLng` method to `GeoPoint`
- Add geojson serializers

## 0.4.1

Add the `toLatLng` method to `GeoSerie`

## 0.4.0

Add the `toStringsMap` method to `GeoPoint`

## 0.3.0

- Update dependencies
- Add pedantic to analysis options
- Use `<String, dynamic>` return type for `toMap` mathods
- Update tests

## 0.2.3

- Add tests
- Minor fixes

## 0.2.2

- Downgrade to `meta` 1.1.6 to be compatible with `flutter_test`

## 0.2.1

- Add missing meta dependency

## 0.2.0

**Breaking change**: remove the Geolocator and Flutter dependencies,
converting this to a pure Dart library

## 0.1.1

- Apply more strict linting rules
- Improve docstrings

## 0.1.0

Initial release