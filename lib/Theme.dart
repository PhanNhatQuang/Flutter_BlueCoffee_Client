import 'package:flutter/material.dart';

class Colors {

  const Colors();


  static const Color appBarTitle = const Color(0xFFFFFFFF);
  static const Color appBarIconColor = const Color(0xFFFFFFFF);
  static const Color appBarDetailBackground = const Color(0x00FFFFFF);
  static const Color appBarGradientStart = const Color(0xFF4873A6);
  static const Color appBarGradientEnd = const Color(0xFF00C6FF);

  static const Color white = const Color(0xFFFFFFFF);
  static const Color green = const Color(0xFF28E828);
  //static const Color bottomappBarGradientEnd = const Color(0xFF42CBC8);
  static const Color bottomappBarGradientEnd = const Color(0xFF41C9C5);
  static const Color bottmappBarGradientStart = const Color(0xFF4873A6);

  //static const Color tableCard = const Color(0xFF434273);
  static const Color tableCard = const Color(0xFF08BCFF);
  //static const Color planetListBackground = const Color(0xFF3E3963);
  static const Color planetPageBackground = const Color(0xFF4C98CF);
  static const Color tableTitle = const Color(0xFFFFFFFF);
  static const Color planetLocation = const Color(0x66FFFFFF);
  static const Color tableDistance = const Color(0x66FFFFFF);

}

class Dimens {
  const Dimens();

  static const planetWidth = 100.0;
  static const planetHeight = 100.0;
}

class TextStyles {

  const TextStyles();

  static const TextStyle appBarTitle = const TextStyle(
    color: Colors.appBarTitle,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 30.0
  );

  static const TextStyle tableTitle = const TextStyle(
    color: Colors.tableTitle,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 24.0
  );
  static const TextStyle tableDetailDrinkTitle = const TextStyle(
    color: Colors.tableTitle,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w800,
    fontSize: 19.0
  );

  static const TextStyle planetLocation = const TextStyle(
    color: Colors.white,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontSize: 16.0
  );

  static const TextStyle tableDetailDate = const TextStyle(
    color: Colors.white,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontSize: 30.0
  );

  static const TextStyle tableDetailDistance = const TextStyle(
    color: Colors.white,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    fontSize: 30.0
  );
  static const TextStyle tableDistance = const TextStyle(
    color: Colors.white,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    fontSize: 16.0
  );


}
