import 'package:final_shop_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


ThemeData darkTheme = ThemeData(
  dialogTheme: DialogTheme(
    backgroundColor: Color(0XFF333739),
    contentTextStyle: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    elevation: 20.0,
  ),
  dividerColor: Colors.grey[300],
  canvasColor: Color(0XFF333739),
  scaffoldBackgroundColor: Color(0XFF333739),
  primarySwatch: defaultColor,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: Color(0XFF333739),
    elevation: 0.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0XFF333739),
      statusBarIconBrightness: Brightness.light,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      elevation: 20.0,
      unselectedItemColor: Colors.grey,
      backgroundColor: Color(0XFF333739)),
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w800,
      color: Colors.white,
    ),
    caption: TextStyle(
      fontSize: 13.0,
      fontWeight: FontWeight.w300,
      color: Colors.white,
    ),
    bodyText1: TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
  ),
  fontFamily: 'Jannah',
);
ThemeData lightTheme = ThemeData(
  dialogTheme: DialogTheme(
    backgroundColor: Colors.white,
    contentTextStyle: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    elevation: 20.0,
  ),
  canvasColor: Colors.white,
  dividerColor: Colors.black26,
  primarySwatch: defaultColor,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Colors.white,
    elevation: 0.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      elevation: 20.0,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white),
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w800,
      color: Colors.black,
    ),
    caption: TextStyle(
      fontSize: 13.0,
      fontWeight: FontWeight.w300,
      color: Colors.black,
    ),
    bodyText1: TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
  ),
  fontFamily: 'Jannah',
);
