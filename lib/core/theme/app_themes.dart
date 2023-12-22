import 'package:flutter/material.dart';

import '../utils/colors.dart';

class appColors {
  // static void LightColors() {
  //   MyColors.color1 = const Color(0xffA7727D);
  //   MyColors.categoriesTextColor = MyColors.color1;
  //   MyColors.navBarIconColor = MyColors.color1;
  //   MyColors.buttonColor = Colors.black;
  //   MyColors.hoverColor = MyColors.color1;
  //   MyColors.color2 = const Color(0xffEDDBC7);
  //   MyColors.color3 = const Color(0xffEDDBC7);
  //   MyColors.customNavBarColor = Colors.white;
  // }
}

class AppThemes {
  static ThemeData LightTheme = ThemeData(
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w900,
        color: Color(0xffA7727D),
      ),
      displaySmall: TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w900,
        color: Color(0xffA7727D),
      ),
    ),
    hintColor: Colors.white,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.white,
    ),
    brightness: Brightness.light,
    iconTheme: const IconThemeData(color: Colors.black),
    indicatorColor: Colors.white,
  );
}
