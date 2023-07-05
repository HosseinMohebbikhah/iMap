import 'package:flutter/material.dart';
import 'package:get/get.dart';

class splashScreenController extends GetxController {
  late Widget tryWidget = const Text("");
  void setTryWidget(Widget wid) {
    tryWidget = wid;
    update(['1']);
  }

  late Widget tryTextWidget = const Text("");
  void setTextWidget(Widget wid) {
    tryTextWidget = wid;
    update(['2']);
  }

  String stringTryWigdet = "Try again!...";
  void setStringTryWigdet(String str) {
    stringTryWigdet = str;
    update(['3']);
  }
}
