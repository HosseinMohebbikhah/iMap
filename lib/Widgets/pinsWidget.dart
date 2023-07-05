// ignore_for_file: must_be_immutable, camel_case_types, file_names
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:imap/Classes/Pins.dart';
import 'package:imap/Controller/iMapController.dart';
import 'package:imap/Widgets/mapWidgets/mapWidget.dart';

class pinsWidget extends GetView<iMapController> {
  late List<Pin> pins;
  late List<Marker> marker;
  pinsWidget({super.key, required this.pins, required this.marker});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GetBuilder<iMapController>(
        id: '1',
        builder: (value) {
          return ListView.builder(
            itemCount: controller.pinsOfPinsWidget.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () async {
                  DefaultTabController.of(context).animateTo(0);
                  await mapWidget.zoomToItemPoint(
                      controller.pinsOfPinsWidget[index].title.toString());
                },
                child: ListTile(
                  leading: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40,
                  ),
                  title: Text(controller.pinsOfPinsWidget[index].title),
                  subtitle: Text(controller.pinsOfPinsWidget[index].caption),
                  key: Key(controller.pinsOfPinsWidget[index].title.toString()),
                  trailing: ElevatedButton(
                    onPressed: () {
                      controller.deletePinFromPinWidget(index);
                      controller.deleteItemFromMarkers(marker[index]);
                    },
                    child: const Icon(Icons.delete_forever),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
