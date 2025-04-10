import 'package:flutter/material.dart';
import 'package:car_connect/core/resource/color_manager.dart';
import 'package:car_connect/core/resource/size_manager.dart';

abstract class AppStyleManager{
  static VisualDensity checkBoxVisualDensity = const VisualDensity(horizontal: -4);
  static double cardImageSize =AppWidthManager.w13;
  static BoxShadow cardImageShadow =BoxShadow(
    color: AppColorManager.greyShadow,
    spreadRadius: 2,
    blurRadius: 10,
  );
}