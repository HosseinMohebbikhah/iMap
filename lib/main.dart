import 'package:flutter/material.dart';
import 'package:imap/bindings/bindings.dart';
import 'Widgets/SplashScreen.dart';
import 'package:get/get.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static String idApp = "8264973051";

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'iMap',
      debugShowCheckedModeBanner: false,
      initialBinding: MyBindings(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}
