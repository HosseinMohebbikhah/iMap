// ignore_for_file: must_be_immutable, prefer_interpolation_to_compose_strings, avoid_print, empty_catches, no_leading_underscores_for_local_identifiers, camel_case_types, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:imap/Classes/Pins.dart';
import 'package:imap/Controller/iMapController.dart';
import 'package:imap/Widgets/mapWidgets/mapWidget.dart';
import 'package:imap/Widgets/mapWidgets/pinSheet.dart';
import 'package:imap/Widgets/mapWidgets/tabs.dart';
import 'package:imap/Widgets/pinsWidget.dart';
import 'package:latlong2/latlong.dart';

class iMap extends GetView<iMapController> {
  late LatLng markerLocation;
  late Pins pins;
  iMap({super.key, required this.markerLocation, required this.pins});

  @override
  Widget build(BuildContext context) {
    //
    pins = pins.onClick(
      (Pin pin) {
        Get.bottomSheet(
          pinSheet(pin: pin),
        );
      },
      pins.jsonString,
    );
    controller.markers = pins.markers;
    controller.addItemToMarkers(
      Marker(
        width: 80,
        height: 80,
        point: markerLocation,
        builder: (ctx) => const Text(''),
      ),
    );
    controller.pinsOfPinsWidget = pins.pins;
    //

    return tabs(
      length: 2,
      children: [
        mapWidget(
          pins: pins,
          markerLocation: markerLocation,
        ),
        pinsWidget(
          pins: pins.pins,
          marker: pins.markers,
        ),
      ],
      menu: Container(
        color: Colors.white54,
        child: const TabBar(
          tabs: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Tab(
                  icon: Icon(
                    Icons.map_outlined,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "Map",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Tab(
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "Pins",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
//----------------------------------------------------------------