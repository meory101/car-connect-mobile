import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/helper/language_helper.dart';
import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/font_manager.dart';
import '../../../../../core/resource/icon_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/widget/text/app_text_widget.dart';
import 'dart:ui' as ui;

import '../../../router/router.dart';
import '../widget/verification_digit_widget.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w4),
          child: Column(
            children: [
              SizedBox(
                height: AppHeightManager.h10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    overlayColor: const WidgetStatePropertyAll(
                        AppColorManager.transparent),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                        LanguageHelper.checkIfLTR(context: context)
                            ? AppIconManager.arrowLeft
                            : AppIconManager.arrowRight,
                        colorFilter: const ColorFilter.mode(
                            AppColorManager.black, BlendMode.srcIn)),
                  ),
                ],
              ),
              SizedBox(
                height: AppHeightManager.h15,
              ),
              AppTextWidget(
                text: "Enter Code",
                fontSize: FontSizeManager.fs24,
                fontWeight: FontWeight.w700,
                color: AppColorManager.navy,
              ),
              SizedBox(
                height: AppHeightManager.h1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w4),
                child: RichText(
                  overflow: TextOverflow.clip,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "",
                    style: TextStyle(
                      fontFamily: FontFamilyManager.cairo,
                      fontSize: FontSizeManager.fs15,
                      color: AppColorManager.grey,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: "",
                          style: TextStyle(
                              fontFamily: FontFamilyManager.cairo,
                              fontSize: FontSizeManager.fs15,
                              color: AppColorManager.navy,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: AppHeightManager.h6,
              ),
              Directionality(
                textDirection: ui.TextDirection.ltr,
                child: VerificationCodeWidget(
                  onCodeEntered: (value) {
                    Navigator.of(context).pushNamed(RouteNamedScreens.personalInfo);
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
