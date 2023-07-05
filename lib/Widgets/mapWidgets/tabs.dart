// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';

class tabs extends StatelessWidget {
  late List<Widget> children;
  late Widget menu;
  late int length;
  tabs(
      {super.key,
      required this.length,
      required this.children,
      required this.menu});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: length,
      child: Scaffold(
          body: TabBarView(children: children), bottomNavigationBar: menu),
    );
  }
}
