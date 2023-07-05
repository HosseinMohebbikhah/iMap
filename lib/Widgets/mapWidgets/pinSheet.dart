// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imap/Classes/Pins.dart';
import 'package:imap/Widgets/PhotoGallery.dart';

class pinSheet extends StatelessWidget {
  late Pin pin;
  pinSheet({required this.pin});

  @override
  Widget build(BuildContext context) {
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
          Row(children: [
            const Icon(Icons.sports_motorsports_outlined, size: 40),
            const SizedBox(
              width: 5,
            ),
            Text(pin.title,
                style: const TextStyle(
                  fontSize: 25,
                )),
          ]),
          const SizedBox(
            height: 2,
          ),
          Text(pin.caption),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Gallery",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          PhotoGallery(photoUrls: pin.photos),
        ],
      ),
    );
  }
}
