import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/resource/color_manager.dart';
import '../../../../core/resource/font_manager.dart';
import '../../../../core/resource/size_manager.dart';

class VerificationCodeWidget extends StatefulWidget {
  final Function(String) onCodeEntered;

  const VerificationCodeWidget({super.key, required this.onCodeEntered});

  @override
  // ignore: library_private_types_in_public_api
  _VerificationCodeWidgetState createState() => _VerificationCodeWidgetState();
}

class _VerificationCodeWidgetState extends State<VerificationCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Pinput(
        autofocus: true,
        keyboardType: TextInputType.number,
        onCompleted: widget.onCodeEntered,
        length: 6,

        androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,

        focusedPinTheme:        PinTheme(
            textStyle: TextStyle(
              fontSize: FontSizeManager.fs16,
            ),
            margin: EdgeInsets.symmetric(horizontal: AppWidthManager.w05),
            decoration: BoxDecoration(
              color: AppColorManager.white,
              boxShadow: const [
                BoxShadow(
                  color: AppColorManager.shadow,
                  blurRadius: 5,
                  spreadRadius: 0,
                  offset:
                  Offset(3, 5),
                ),
              ],
              border: Border.all(
                  color: AppColorManager.textAppColor
              ),

              borderRadius: BorderRadius.circular(AppRadiusManager.r15),
            ),
            height: AppWidthManager.w18,
            width: AppWidthManager.w16),

        defaultPinTheme:
        PinTheme(
            textStyle: TextStyle(
              fontSize: FontSizeManager.fs16,
            ),
            margin: EdgeInsets.symmetric(horizontal: AppWidthManager.w05),
            decoration: BoxDecoration(
              color: AppColorManager.white,
              border: Border.all(
                color: AppColorManager.grey
              ),

              borderRadius: BorderRadius.circular(AppRadiusManager.r15),
            ),
            height: AppWidthManager.w18,
            width: AppWidthManager.w16),
      ),
    );
  }
}
