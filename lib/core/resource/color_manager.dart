import 'package:flutter/material.dart';

abstract class AppColorManager {

  static const Color navy =Color.fromARGB(255, 27, 10, 255);
  static const Color textBlack = Color(0xff353537);
  static const Color darkNavy = Color.fromARGB(255, 27, 10, 255);
  static const Color teal = Color.fromARGB(255, 27, 10, 255);
  static const Color textAppColor = Color(0xff171717);
  static const Color black = Color(0xff171717);
  static const Color white = Color(0xffffffff);
  static const Color gold = Color(0xFFB8860B);

  static const Color blue = Color(0xff007AFF);
  static const Color background = Color.fromARGB(255, 10, 17, 37);
  static const Color grey = Color(0xff8e8e93);
  static const Color lightGrey = Color(0xff85868B);
  static Color greyWithOpacity6 = const Color(0xffe5e5ea).withOpacity(0.6);
  static Color greyWithOpacity1 = const Color(0xff828282).withOpacity(0.1);
  static const Color shimmerHighlightColor = Color(0xffd9d9d9);
  static const Color shimmerBaseColor = Color(0xffe0e0e0);
  static const Color dotGrey = Color(0xffE5E5EA);
  static const Color shadow = Color.fromARGB(28, 130, 130, 130);
  static const Color textGrey = Color(0xffAEAFB2);
  static  Color greyShadow = const Color(0xffAEAFB2).withOpacity(0.2);
  static const Color buttonColor = Color(0xffCFD0D2);
  static const Color yellow = Color(0xffFF9500);
  static const Color green = Color(0xff34C759);
  static const Color transparent = Colors.transparent;
  static Color buttonColorOpacity8 = const Color(0xffCFD0D2).withOpacity(0.8);
  static const Color backgroundGrey = Color(0xffF2F2F7);
  static const Color red = Color(0xffff3b30);
  static Color greenOpacity15 = const Color(0xff34c759).withOpacity(0.15);
  static Color redOpacity15 = const Color(0xffff3b30).withOpacity(0.15);
}
