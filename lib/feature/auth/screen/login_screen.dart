import 'package:car_connect/core/resource/font_manager.dart';
import 'package:car_connect/core/resource/size_manager.dart';
import 'package:car_connect/core/widget/button/main_app_button.dart';
import 'package:car_connect/core/widget/form_field/app_form_field.dart';
import 'package:car_connect/core/widget/text/app_text_widget.dart';
import 'package:car_connect/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/resource/color_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int selectedType = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppWidthManager.w3Point8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: AppHeightManager.h20),
              AppTextWidget(
                text: "Login",
                color: AppColorManager.white,
                fontWeight: FontWeight.w600,
                fontSize: FontSizeManager.fs24,
              ),
              SizedBox(
                height: AppHeightManager.h1point8,
              ),
              AppTextWidget(
                text:
                    "Welcome to car connect please enter your number to continue...!",
                color: AppColorManager.white,
                fontWeight: FontWeight.w600,
                fontSize: FontSizeManager.fs16,
                maxLines: 2,
              ),
              SizedBox(
                height: AppHeightManager.h9,
              ),
              AppTextFormField(
                hintText: "number",
                onChanged: (p0) {},
                validator: (p0) {},
              ),
              SizedBox(
                height: AppHeightManager.h9,
              ),
              Row(
                children: [
                  Expanded(
                    child: MainAppButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: AppWidthManager.w10),
                      borderRadius: BorderRadius.circular(AppRadiusManager.r10),
                      height: AppHeightManager.h7point5,
                      onTap: () {
                        setState(() {
                          selectedType = 0;
                        });
                      },
                      color: selectedType == 0
                          ? AppColorManager.navy
                          : AppColorManager.white,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppTextWidget(
                            text: "Customer",
                            fontSize: FontSizeManager.fs15,
                            color: selectedType == 1
                                ? AppColorManager.navy
                                : AppColorManager.white,                                ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: AppWidthManager.w1Point2,
                  ),
                  Expanded(
                    child: MainAppButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: AppWidthManager.w10),
                      borderRadius: BorderRadius.circular(AppRadiusManager.r10),
                      height: AppHeightManager.h7point5,
                      onTap: () {
                        setState(() {
                          selectedType=1;
                        });
                      },
                      color: selectedType == 1
                          ? AppColorManager.navy
                          : AppColorManager.white,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppTextWidget(
                            text: "Business",
                            fontSize: FontSizeManager.fs15,
                            color: selectedType == 0
                                ? AppColorManager.navy
                                : AppColorManager.white,                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AppHeightManager.h5,
              ),
              MainAppButton(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteNamedScreens.verification);
                },
                alignment: Alignment.center,
                width: AppWidthManager.w100,
                color: AppColorManager.navy,
                height: AppHeightManager.h6,
                child: AppTextWidget(
                  text: "login",
                  color: AppColorManager.white,
                  fontWeight: FontWeight.w600,
                  fontSize: FontSizeManager.fs15,
                  maxLines: 2,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
