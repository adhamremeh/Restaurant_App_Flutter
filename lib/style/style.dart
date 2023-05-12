import 'package:flutter/material.dart';

class CustomStyle {
  static final _colorPalette colorPalette = _colorPalette();
  static final _fontSizes fontSizes = _fontSizes();
}

class _colorPalette {
//write your colors here
  Color orange = Color(0xFFEA7C69);
  Color orangeShadow = Color(0xFFF39F91);
  Color lightBackgorund = Color(0xFF252836);
  Color darkBackground = Color(0xFF1F1D2B);
  Color textColor = Color(0xFFfbfbff);
  Color yellow = Color(0xFFFFFF0E);
  Color yellowShadow = Color(0xFFF9F92D);
  Color red = Color(0xFFF60616);
  Color redShadow = Color(0xFFF22230);
  Color blue = Color(0xFF0645F6);
  Color blueShadow = Color(0xFF5681FC);
  Color green = Color(0xFF7EF606);
  Color greenShadow = Color(0xFF6DC21A);
  Color textField = Color(0xFF2D303E);
  Color textFieldShadow = Color(0xFF393D4F);
}

class _fontSizes {
  //write common font size here
  double titleFont = 35;
  double gridViewFont = 60;
  double buttonTextFont = 30;
  double orderDetailsFont = 25;
  double itemOrderFont = 17;
  double tabBarFont = 17;
  double employeeNameFont = 20;
  double employeeIdFont = 20;
  double textFieldFont = 15;
  double uploadButtonFont = 15;
}
