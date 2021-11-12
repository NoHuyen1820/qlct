// import 'package:flutter/material.dart';
import 'dart:ui';

const Color primary = Color(0xFFFF3378);
const Color secondary = Color(0xFFFF2278);
const Color black = Color(0xFF000000);
const Color white = Color(0xFFFFFFFF);
const Color grey = Color(0xff6b6868);
const Color red = Color(0xFFec5766);
const Color green = Color(0xFF43aa8b);
const Color blue = Color(0xFF28c2ff);

class RallyColors {
  static const List<Color> accountColors = <Color>[
    Color(0xFF005D57),
    Color(0xFF04B97F),
    Color(0xFF37EFBA),
    Color(0xFF007D51),
  ];

  static const List<Color> billColors = <Color>[
    Color(0xFFFFDC78),
    Color(0xFFFF6951),
    Color(0xFFFFD7D0),
    Color(0xFFFFAC12),
  ];

  static const List<Color> budgetColors = <Color>[
    Color(0xFFB2F2FF),
    Color(0xFFB15DFF),
    Color(0xFF72DEFF),
    Color(0xFF0082FB),
  ];

  static const Color gray = Color(0xFFD8D8D8);
  static const Color gray60 = Color(0x99D8D8D8);
  static const Color gray25 = Color(0x40D8D8D8);
  static const Color white60 = Color(0x99FFFFFF);
  static const Color primaryBackground = Color(0xFF33333D);
  static const Color inputBackground = Color(0xFF26282F);
  static const Color cardBackground = Color(0x03FEFEFE);
  static const Color buttonColor = Color(0xFF09AF79);
  static const Color focusColor = Color(0xCCFFFFFF);
  static const Color dividerColor = Color(0xAA282828);

  /// Convenience method to get a single account color with position i.
  static Color accountColor(int i) {
    return cycledColor(accountColors, i);
  }

  /// Convenience method to get a single bill color with position i.
  static Color billColor(int i) {
    return cycledColor(billColors, i);
  }

  /// Convenience method to get a single budget color with position i.
  static Color budgetColor(int i) {
    return cycledColor(budgetColors, i);
  }

  /// Gets a color from a list that is considered to be infinitely repeating.
  static Color cycledColor(List<Color> colors, int i) {
    return colors[i % colors.length];
  }
}

class QLCTColors {

  static const Color mainColor = Color(0xFF7b68ee);
  static const Color mainColorLight = Color(0xFFB15DFF);

  static const Color primaryColorDark = Color(0xFF7200CA);
  static const Color primaryColor = Color(0xFFAA00FF);
  static const Color primaryColorLight = Color(0xFFE254FF);

  static const Color blueColor = Color(0xFF0082FB);
  static const Color cyanColor = Color(0xFF72DEFF);
  static const Color cyanColorLight = Color(0xFFB2F2FF);

  static const Color whiteColor = Color(0xFBFEFFFF);


}