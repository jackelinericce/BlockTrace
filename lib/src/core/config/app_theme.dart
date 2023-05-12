import 'package:flutter/material.dart';

class MyAppTheme {
  var color = Colors.yellow;

  static ThemeData theme = ThemeData(
    fontFamily: 'Nunito',
    useMaterial3: true,
    primarySwatch: Colors.purple,
    primaryColor: Colors.purple,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      color: Colors.purple,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
    tabBarTheme: const TabBarTheme(labelColor: Colors.white, ),
    scaffoldBackgroundColor: Colors.deepPurple[50],
  );
}
