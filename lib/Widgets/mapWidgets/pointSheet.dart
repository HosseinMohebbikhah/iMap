// ignore_for_file: prefer_interpolation_to_compose_strings, must_be_immutable, camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imap/Classes/Pins.dart';
import 'package:imap/Controller/iMapController.dart';
import 'package:imap/Widgets/TextInputDialog.dart';
import 'package:imap/Widgets/mapWidgets/pinSheet.dart';
import 'package:latlong2/latlong.dart';

class pointSheet extends StatelessWidget {
  late LatLng loc;
  late String title;
  pointSheet({super.key, required this.loc, this.title = ""});

  @override
  Widget build(BuildContext context) {
    iMapController controller = Get.put(iMapController());

    controller.setInfoPoint(loc.latitude, loc.longitude);

    return Container(
      height: Get.height * 0.4,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (title != "")
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          if (title != "")
            const SizedBox(
              height: 10,
            ),
          Text(
            "${loc.latitude.toStringAsFixed(7)}, ${loc.longitude.toStringAsFixed(7)}",
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () {
              if (controller.okInfo.value) {
                return Text(
                  "استان : " +
                      controller.info.value.state.toString() +
                      "\nشهر : " +
                      controller.info.value.city.toString() +
                      "\nآدرس : " +
                      controller.info.value.formattedAddress.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.right,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                );
              }
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                final result = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return TextInputDialog(
                      title: "Add this point to pins",
                      loc:
                          "${loc.latitude.toStringAsFixed(7)}, ${loc.longitude.toStringAsFixed(7)}",
                    );
                  },
                );

                Pin pin = Pin(
                  title: result[0],
                  caption: result[1],
                  photos: [
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFlGYG0gVBPFHz99KzosT9O1vRXlN8PkeKDQ&usqp=CAU",
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFlGYG0gVBPFHz99KzosT9O1vRXlN8PkeKDQ&usqp=CAU"
                  ],
                  lat: loc.latitude,
                  lng: loc.longitude,
                  onClick: (loca) {
                    Get.bottomSheet(
                      pinSheet(pin: loca),
                    );
                  },
                );
                controller.addPinFromPinWidget(pin);
                controller.addItemToMarkers(pin.buildMarker());
                Get.back();
              },
              child: SizedBox(
                width: Get.width,
                child: const Text(
                  "Add to pins",
                  textAlign: TextAlign.center,
                ),
              )),
        ],
      ),
    );
  }
}
