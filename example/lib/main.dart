import 'package:flutter/material.dart';
import 'package:geopoint/geopoint.dart';

class _MyHomePageState extends State<MyHomePage> {
  GeoPoint geoPoint;

  void setGeoPoint() {
    GeoPoint.getPosition(verbose: true).then((p) {
      setState(() {
        geoPoint = p;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: const Text("Get current geopoint"),
                onPressed: () => setGeoPoint(),
              ),
              Text("$geoPoint"),
            ],
          )),
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geopoint example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
