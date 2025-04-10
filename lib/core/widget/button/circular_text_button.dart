import 'package:flutter/material.dart';
import 'package:car_connect/core/resource/font_manager.dart';
import 'package:car_connect/core/resource/size_manager.dart';
import 'package:car_connect/core/widget/text/app_text_widget.dart';

class CircularTextButton extends StatelessWidget {
  final String buttonText;
  final Color? boxColor;
  final Color? textColor;
  final Function() onTap;


  const CircularTextButton(
      {super.key,
      required this.buttonText,
      required this.boxColor,
      required this.textColor,
        required this.onTap
});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            vertical: AppHeightManager.h06, horizontal: AppWidthManager.w3Point8),
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(AppRadiusManager.r16),
        ),
        child: AppTextWidget(
          text: buttonText,
          fontWeight: FontWeight.w400,
          fontSize: FontSizeManager.fs14,
          color: textColor,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
