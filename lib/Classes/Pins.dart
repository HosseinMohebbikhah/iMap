import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Pin {
  late String title;
  late String caption;
  late List<String> photos;
  late double lat;
  late double lng;
  late Function(Pin) onClick;
  Pin({
    required this.title,
    required this.caption,
    required this.photos,
    required this.lat,
    required this.lng,
    required this.onClick,
  });

  Marker buildMarker() {
    return Marker(
      width: 80,
      height: 80,
      point: LatLng(lat, lng),
      builder: (ctx) => GestureDetector(
        onTap: () {
          onClick(this);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: Colors.red[400],
              size: 50,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Pins {
  final bool ok;
  final List<Pin> pins;
  final List<Marker> markers;
  late String jsonString;
  Pins({
    required this.ok,
    required this.pins,
    required this.markers,
    required this.jsonString,
  });

  Pins onClick(Function(Pin) _onClick, String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    List<Pin> _pin = [];
    List<Marker> _marker = [];
    for (var i = 0; i < json['pins'].length; i++) {
      List<String> photsss = [
        json['pins'][i]['photos'][0],
        json['pins'][i]['photos'][1],
      ];
      Pin myPin = Pin(
        title: json['pins'][i]['title'],
        caption: json['pins'][i]['caption'],
        photos: photsss,
        lat: json['pins'][i]['lat'],
        lng: json['pins'][i]['lng'],
        onClick: _onClick,
      );
      _pin.add(myPin);
      _marker.add(myPin.buildMarker());
    }
    return Pins(ok: json['ok'], pins: _pin, markers: _marker, jsonString: "");
  }

  factory Pins.fromJson(String jsonString) {
    def(Pin pin) {}
    Map<String, dynamic> json = jsonDecode(jsonString);
    List<Pin> _pin = [];
    List<Marker> _marker = [];
    for (var i = 0; i < json['pins'].length; i++) {
      List<String> photsss = [
        json['pins'][i]['photos'][0],
        json['pins'][i]['photos'][1],
      ];
      Pin myPin = Pin(
        title: json['pins'][i]['title'],
        caption: json['pins'][i]['caption'],
        photos: photsss,
        lat: json['pins'][i]['lat'],
        lng: json['pins'][i]['lng'],
        onClick: def,
      );
      _pin.add(myPin);
      _marker.add(myPin.buildMarker());
    }
    return Pins(
        ok: json['ok'], pins: _pin, markers: _marker, jsonString: jsonString);
  }
}
