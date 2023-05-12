import 'package:flutter/material.dart';

class CustomStyle {
  static final _colorPalette colorPalette = _colorPalette();
  static final _fontSizes fontSizes = _fontSizes();
}

class _colorPalette {
//write your colors here
  Color activeOrange = Color.fromARGB(255, 227, 123, 100);
  Color backgroundBlue1 = Color.fromARGB(255, 38, 40, 55);
  Color backgroundBlue2 = Color.fromARGB(255, 31, 29, 44);
  Color brightWhite = Color.fromARGB(255, 252, 251, 253);
  Color midWhite = Color.fromARGB(255, 224, 222, 225);
  Color dimWhite = Color.fromARGB(255, 187, 185, 188);
}

class _fontSizes {
  //write common font size here
  double miniSize = 14.0;
  double medium = 20.0;
  double large = 30;
}
