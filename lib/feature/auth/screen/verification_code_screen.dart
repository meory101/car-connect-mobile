import 'dart:convert';

import 'package:car_connect/core/storage/shared/shared_pref.dart';
import 'package:car_connect/feature/auth/model/verification_request_entity.dart';
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
import 'package:http/http.dart'as http;
import '../../../core/api/api_links.dart';
import '../../../core/api/api_methods.dart';
import '../../../router/router.dart';
import '../widget/verification_digit_widget.dart';

class VerificationCodeScreen extends StatefulWidget {
  final VerificationArgs args;
  const VerificationCodeScreen({super.key,required this.args});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  int status = -1;

  void onCodeEntered(String code) async {

    setState(() {
      status = 0;
    });

    VerificationRequestEntity entity = VerificationRequestEntity();
    entity.phone = widget.args.phone;
    entity.type = widget.args.type;
    entity.code = code;
    http.Response response =
    await HttpMethods().postMethod(ApiPostUrl.verifyCode, entity.toJson());
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        status = 1;
      });

      if ((response.body ?? "").isNotEmpty) {
        Navigator.of(context).pushNamed(RouteNamedScreens.personalInfo);
      }
    } else {
      setState(() {
        status = 2;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColorManager.white,
          content: AppTextWidget(
            text: "Something went wrong check code",
            color: AppColorManager.navy,
            fontSize: FontSizeManager.fs16,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.visible,
          ),
        ),
      );
    }
  }

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
                    onCodeEntered(value);
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

class VerificationArgs{
  String type;
  String phone;
  VerificationArgs({required this.type,required this.phone});
}