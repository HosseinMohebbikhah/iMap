// ignore_for_file: must_be_immutable, prefer_interpolation_to_compose_strings, avoid_print, empty_catches, no_leading_underscores_for_local_identifiers, camel_case_types, sort_child_properties_last, file_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:imap/Classes/Database.dart';
import 'package:imap/Classes/Pins.dart';
import 'package:imap/Classes/premession.dart';
import 'package:imap/Controller/iMapController.dart';
import 'package:imap/Widgets/mapWidgets/pinSheet.dart';
import 'package:imap/Widgets/mapWidgets/pointSheet.dart';
import 'package:latlong2/latlong.dart';
import 'dart:math';
import 'package:location/location.dart' hide PermissionStatus;
import 'package:imap/Classes/LatLngTween.dart';

class mapWidget extends GetView<iMapController> {
  late Pins pins;
  late LatLng markerLocation;

  mapWidget({super.key, required this.pins, required this.markerLocation});

  //initValues
  static late MapController mapController;
  static late Pins piins;
  final bool okLoc = false;
  bool zomed = false;
  bool startAnimation = false;
  bool okOnecRun = false;
  final TextEditingController _searchController = TextEditingController();
  //

  Future<bool> zoomToPoint(
      double latitude, double longitude, double zoom) async {
    return mapController.move(LatLng(latitude, longitude), zoom);
  }

  static Future<bool> zoomToItemPoint(String titleOfPin,
      {bool openSheet = true}) async {
    Pin pin =
        piins.pins.where((element) => (element.title == titleOfPin)).first;
    mapController.move(LatLng(pin.lat, pin.lng), 18);
    await Future.delayed(const Duration(seconds: 1));
    if (openSheet) {
      Get.bottomSheet(
        pinSheet(pin: pin),
      );
    }
    return true;
  }

  double distanceBetween(LatLng pos1, LatLng pos2) {
    return distanceInMeters(
        pos1.latitude, pos1.longitude, pos2.latitude, pos2.longitude);
  }

  double distanceInMeters(double lat1, double lng1, double lat2, double lng2) {
    const double earthRadius = 6371000; // in meters
    double dLat = _toRadians(lat2 - lat1);
    double dLng = _toRadians(lng2 - lng1);
    double a = pow(sin(dLat / 2), 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) * pow(sin(dLng / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;
    return distance;
  }

  double _toRadians(double degree) {
    return degree * pi / 180;
  }

  bool okOnecRun1 = false;
  bool okZoming = true;
  void _onMapPositionChanged(MapPosition position, bool hasGesture) {
    if (okOnecRun1) {
      final LatLng location =
          LatLng(markerLocation.latitude, markerLocation.longitude);
      final LatLngBounds? bounds = mapController.bounds;
      if (bounds != null && !bounds.contains(location)) {
        controller.setIcoButton(const Icon(Icons.location_searching));
      } else {
        controller.setIcoButton(const Icon(Icons.my_location));
      }
    }
  }

  Marker getMarkerCurrentLoc(LatLng loc) {
    return Marker(
      key: const Key('currentLoc'),
      width: 80,
      height: 80,
      point: loc,
      builder: (ctx) => GestureDetector(
        onTap: () async {
          await Get.bottomSheet(
            pointSheet(
              loc: loc,
              title: "You're here",
            ),
          );
          controller.okInfo.value = false;
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 18,
            ),
            Icon(
              Icons.circle,
              color: Colors.blue[300],
              size: 20,
            ),
            const Text(
              "You're here",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    mapController = MapController();
    piins = pins;

    void animateMarker(LatLng newLocation) {
      try {
        double distance = distanceBetween(markerLocation, newLocation);
        Duration duration = Duration(milliseconds: (distance * 10).round());
        Tween<LatLng> tween =
            LatLngTween(begin: markerLocation, end: newLocation);
        AnimationController controllerr = AnimationController(
            duration: duration, vsync: Scaffold.of(context));
        Animation<LatLng> animation = tween
            .animate(CurvedAnimation(parent: controllerr, curve: Curves.ease));
        animation.addListener(() {
          controller
              .deleteMarkerCurrentLocation(getMarkerCurrentLoc(markerLocation));
          controller.addItemFromMarkers(getMarkerCurrentLoc(newLocation));
          markerLocation = animation.value;
        });
        controllerr.forward();
      } on Exception {}
    }

    Future<void> _startLocationSubscription() async {
      bool okloc = true;
      final location = Location();
      PermissionService permissionService = PermissionService();
      bool permissionEnabled =
          await permissionService.requestLocationPermission();
      if (!permissionEnabled) {
        okloc = false;
      }
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          okloc = false;
        }
      }

      await Future.delayed(const Duration(seconds: 1));

      if (okloc) {
        okOnecRun = true;
        location.onLocationChanged.listen((locationData) async {
          print("Get new location info");
          if (!okOnecRun1) {
            okOnecRun1 = true;
            controller.setIcoButton(const Icon(Icons.my_location));
          }
          final loca = LatLng(locationData.latitude ?? markerLocation.latitude,
              locationData.longitude ?? markerLocation.longitude);
          final database = await getDatabase();
          await database.update(
            'loc',
            {'lat': loca.latitude, 'lng': loca.longitude},
            where: 'id = ?',
            whereArgs: [1],
          );
          print("lat=" + loca.latitude.toString());
          print("lng=" + loca.longitude.toString());

          if (!zomed) {
            controller.deleteMarkerCurrentLocation(
                getMarkerCurrentLoc(markerLocation));
            controller.addItemFromMarkers(getMarkerCurrentLoc(loca));
            zoomToPoint(loca.latitude, loca.longitude, 18);
          }
          if (startAnimation && zomed) {
            animateMarker(loca);
            markerLocation = loca;
          } else {
            markerLocation = loca;
            startAnimation = true;
          }
          zomed = true;
        });
      }

      if (okOnecRun) {
        await zoomToPoint(
            markerLocation.latitude, markerLocation.longitude, 18);
      }
    }

    return Center(
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            height: 750,
            child: GetBuilder<iMapController>(
              id: '3',
              builder: (value) {
                return FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    center: markerLocation,
                    zoom: 18,
                    keepAlive: true,
                    interactiveFlags:
                        InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                    onPositionChanged: _onMapPositionChanged,
                    onLongPress: (tap, loc) async {
                      dynamic marker = Marker(
                        width: 80,
                        height: 80,
                        point: loc,
                        builder: (ctx) => Icon(
                          Icons.not_listed_location,
                          color: Colors.amber.shade700,
                          size: 50,
                        ),
                      );
                      controller.addPinOfLongPressed(marker);
                      await Get.bottomSheet(
                        pointSheet(
                          loc: loc,
                        ),
                      );
                      controller.deletePinOfLongPressed(marker);
                      controller.okInfo.value = false;
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    AttributionWidget(
                      attributionBuilder: (_) => const Text(
                        '   © iMap\n   © OpenStreetMap\n',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromRGBO(97, 97, 97, 1),
                          fontSize: 12,
                        ),
                      ),
                      alignment: Alignment.bottomLeft,
                    ),
                    MarkerLayer(
                      markers: controller.markers,
                    ),
                  ],
                );
              },
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width * 0.9,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search in registered pins',
                      contentPadding: const EdgeInsets.all(15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        controller.deleteFilteredItem();
                        return;
                      }

                      controller.addFilteredItem(pins.pins
                          .where((item) =>
                              item.title.toLowerCase().contains(value))
                          .toList());
                    },
                  ),
                ),
                GetBuilder<iMapController>(
                  id: '2',
                  builder: (value) {
                    if (controller.filteredItems.isNotEmpty) {
                      return SizedBox(
                        width: Get.width * 0.9,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: controller.filteredItems
                                .map(
                                  (item) => Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.deleteFilteredItem();
                                        _searchController.text = "";
                                        FocusScope.of(context).unfocus();
                                        zoomToItemPoint(
                                          item.title,
                                          openSheet: false,
                                        );
                                      },
                                      child: Chip(
                                        label: Text(item.title),
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      );
                    } else {
                      return const Text("");
                    }
                  },
                ),
              ],
            ),
          ),
          Positioned(
            top: 680,
            left: 310,
            child: Container(
              // width: 100,
              // height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Obx(
                () {
                  return IconButton(
                    icon: controller.icoButton.value,
                    onPressed: () => {_startLocationSubscription()},
                    // {if (okLoc) zoomToPoint(latitude, longitude, 18)},
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
