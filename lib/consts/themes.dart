import 'package:flutter/material.dart';

/////////////////////////////////////////////////////////////////////////////////////////
/////////Light Themes

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.orange,
  cardColor: Colors.orangeAccent,
  canvasColor: Colors.white70,
  primaryColorDark: Colors.black,
  primaryColorLight: Colors.white,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.orange,
    accentColor: Colors.orangeAccent,
  ),
);

/////////////////////////////////////////////////////////////////////////////////////////
/////////Dark Themes

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  primaryColor: Colors.orange,
  cardColor: Colors.orangeAccent,
  canvasColor: Colors.grey.shade700,
  primaryColorDark: Colors.white,
  primaryColorLight: Colors.black,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.orange,
    accentColor: Colors.orangeAccent,
  ),
);


