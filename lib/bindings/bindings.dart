import 'package:get/get.dart';
import 'package:imap/Controller/iMapController.dart';
import 'package:imap/Controller/splashScreenController.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => iMapController());
    Get.lazyPut(() => splashScreenController());
  }
}
