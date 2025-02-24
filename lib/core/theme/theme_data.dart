// ignore_for_file: prefer_const_constructors

import 'package:booky/core/constant/app_color.dart';
import 'package:flutter/material.dart';


class CustomThemeData {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.light(
        brightness: Brightness.light,
        primary: AppColor.primaryColor,
      ),  
      
      appBarTheme: AppBarTheme( iconTheme: IconThemeData(color: Colors.white)  ),
      textTheme: TextTheme(
        titleSmall:
            TextStyle(fontFamily: 'Roboto', color: AppColor.secandryColor),
        bodyLarge:
            TextStyle(fontFamily: 'Roboto', color: AppColor.secandryColor),
        bodyMedium:
            TextStyle(fontFamily: 'Roboto', color: AppColor.secandryColor),
        bodySmall:
            TextStyle(fontFamily: 'Roboto', color: AppColor.secandryColor ,   ),
        displaySmall:
            TextStyle(fontFamily: 'Roboto', color: AppColor.secandryColor),
      ),
      fontFamily: 'Roboto',
    );
  }
}
