import 'package:flutter/material.dart';

class Util{
  static BoxDecoration buildPostBoxDecoration() {
    return BoxDecoration(
      border: Border(
          bottom:
          BorderSide(color: Color.fromARGB(255, 57, 57, 57), width: 0.5)),
    );
  }
}