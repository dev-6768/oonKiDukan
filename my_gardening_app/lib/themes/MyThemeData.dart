import 'package:flutter/material.dart';

class MyThemeData {

  ThemeData MyThemeDataForApp(BuildContext context) {
      ThemeData themeDataApp = ThemeData(
      primarySwatch: Colors.green,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
        ),
      ),
    );
    return themeDataApp;
  }
}