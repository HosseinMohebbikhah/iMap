import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:imap/Classes/Pins.dart';
import 'package:imap/Classes/getServer.dart';
import 'package:imap/Classes/infoPoint.dart';

class iMapController extends GetxController {
  var icoButton = Icon(Icons.location_searching).obs;
  void setIcoButton(Icon ico) {
    icoButton.value = ico;
  }

  var selectedIndex = 0.obs;
  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  //
  late List<Marker> markers = [];
  void addItemFromMarkers(Marker marker) {
    markers.add(marker);
    update(['3']);
  }

  void deleteItemFromMarkers(Marker marker) {
    markers.remove(marker);
    update(['3']);
  }

  void deleteMarkerCurrentLocation(Marker marker) {
    markers.removeWhere((marker) => marker.key == const Key('currentLoc'));
    update(['3']);
  }

  void addItemToMarkers(Marker marker) {
    markers.add(marker);
    update(['3']);
  }

  void addPinOfLongPressed(Marker marker) {
    markers.add(marker);
    update(['3']);
  }

  void deletePinOfLongPressed(Marker marker) {
    markers.remove(marker);
    update(['3']);
  }
  //

  late var okInfo = false.obs;
  late Rx<infoPoint> info;
  void setInfoPoint(double lat, double lng) async {
    if (!okInfo.value) {
      getServer server = getServer();
      dynamic inf = await server.getInfoPoint(lat, lng);
      if (inf is infoPoint) {
        info = (inf as infoPoint).obs;
        okInfo.value = true;
      }
    }
  }

  late List<Pin> pinsOfPinsWidget = [];
  void deletePinFromPinWidget(int index) {
    pinsOfPinsWidget.removeAt(index);
    update(['1']);
  }

  void addPinFromPinWidget(Pin pin) {
    pinsOfPinsWidget.add(pin);
    update(['1']);
  }

  List<Pin> filteredItems = [];
  void addFilteredItem(List<Pin> pins) {
    filteredItems = pins;
    update(['2']);
  }

  void deleteFilteredItem() {
    filteredItems = [];
    update(['2']);
  }
}
