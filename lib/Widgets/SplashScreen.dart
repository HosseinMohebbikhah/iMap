// ignore_for_file: avoid_print, prefer_is_empty, use_key_in_widget_constructors, must_be_immutable, depend_on_referenced_packages, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imap/Classes/Database.dart';
import 'package:imap/Classes/Pins.dart';
import 'package:imap/Controller/splashScreenController.dart';
import 'package:imap/Widgets/imap.dart';
import 'package:connectivity/connectivity.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

Future<bool> checkInternetConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    return true;
  } else {
    return false;
  }
}

class SplashScreen extends GetView<splashScreenController> {
  late iMap imap;
  late Pins _pins;

  Future<bool> getPins() async {
    try {
      String apiUrl = "https://myapi.themohebbikhah.ir/app8264973051/iMap/init";
      Map<String, String> postData = {"id": "8264973051", "fun": "getPins"};
      http.Response response =
          await http.post(Uri.parse(apiUrl), body: postData);
      if (response.statusCode == 200) {
        print(response.body);
        _pins = Pins.fromJson(response.body);
        return true;
      }
    } catch (E) {
      print(E);
      return false;
    }
    return false;
  }

  Future<bool> _initFunction() async {
    print('Initializing app...');
    bool hasInternetConnection = await checkInternetConnection();
    if (hasInternetConnection) {
      print('Internet connection is available.');
    } else {
      print('Internet connection is not available.');
      await Future.delayed(const Duration(seconds: 2));
      return false;
    }
    LatLng location = LatLng(35.7219, 51.3347);
    final database = await getDatabase();
    final List<Map<String, dynamic>> maps = await database.query('loc');
    if (maps.length > 0) {
      final locationData = maps.first;
      location.latitude = locationData['lat'];
      location.longitude = locationData['lng'];
    } else {
      await database.insert(
        'loc',
        {'id': 1, 'lat': 35.7219, 'lng': 51.3347},
      );
    }
    if (!(await getPins())) return false;
    await Future.delayed(const Duration(seconds: 3));
    imap = iMap(markerLocation: location, pins: _pins);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initFunction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == true) {
              return imap;
            } else {
              controller.setTryWidget(
                TextButton(
                  onPressed: () async {
                    controller.setStringTryWigdet("Checking...");
                    controller.setTextWidget(const Text(""));
                    bool result = await _initFunction();
                    if (result) {
                      Get.off(imap);
                    } else {
                      controller.setStringTryWigdet("Try again!...");
                      controller.setTextWidget(
                        const Text(
                          "You do not have access to the Internet",
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      backgroundColor: Colors.white,
                      fixedSize: const Size(200, 50)),
                  child: SizedBox(
                    width: Get.width / 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.refresh),
                        GetBuilder<splashScreenController>(
                          id: '3',
                          builder: (value) {
                            return Text(controller.stringTryWigdet);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
              controller.setTextWidget(
                const Text(
                  "You do not have access to the Internet",
                  textAlign: TextAlign.center,
                ),
              );
            }
          }
          return Stack(
            children: [
              Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.white,
                    child: const Icon(
                      Icons.map,
                      size: 80,
                    ),
                  ),
                ],
              ),
              Positioned(
                top: Get.height * 0.7,
                width: Get.width / 2,
                left: (Get.width / 2) / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GetBuilder<splashScreenController>(
                      id: '1',
                      builder: (value) {
                        return controller.tryWidget;
                      },
                    ),
                    const SizedBox(height: 10),
                    GetBuilder<splashScreenController>(
                      id: '2',
                      builder: (value) {
                        return controller.tryTextWidget;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/imgs/a0.png',
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mohebbikhah",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Services And Products",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
