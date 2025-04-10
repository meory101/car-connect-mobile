import 'dart:convert';

import 'package:car_connect/core/resource/font_manager.dart';
import 'package:car_connect/core/resource/size_manager.dart';
import 'package:car_connect/core/widget/button/main_app_button.dart';
import 'package:car_connect/core/widget/form_field/app_form_field.dart';
import 'package:car_connect/core/widget/loading/app_circular_progress_widget.dart';
import 'package:car_connect/core/widget/snack_bar/note_message.dart';
import 'package:car_connect/core/widget/text/app_text_widget.dart';
import 'package:car_connect/feature/auth/model/generate_otp_request_entitiy.dart';
import 'package:car_connect/feature/auth/model/generate_otp_response_entity.dart';
import 'package:car_connect/feature/auth/screen/verification_code_screen.dart';
import 'package:car_connect/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../core/api/api_links.dart';
import '../../../core/api/api_methods.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/storage/shared/shared_pref.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int selectedType = 0;
  int status = -1;

  TextEditingController phoneController = TextEditingController();

  void onLoginClicked() async {
    setState(() {
      status = 0;
    });
    if (phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColorManager.white,
          content: AppTextWidget(
            text: "enter your number",
            color: AppColorManager.navy,
            fontSize: FontSizeManager.fs16,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.visible,
          ),
        ),
      );
      return;
    }
    GenerateOtpRequestEntitiy entity = GenerateOtpRequestEntitiy();
    entity.phone = phoneController.text;
    entity.type = selectedType.toString();
    http.Response response =
        await HttpMethods().postMethod(ApiPostUrl.generateOtp, entity.toJson());
    GenerateOtpResponseEntity authResponseEntity;
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        status = 1;
      });

      if ((response.body ?? "").isNotEmpty) {
        authResponseEntity = generateOtpResponseEntityFromJson(response.body);
        NoteMessage.showSuccessSnackBar(
            context: context,
            text: authResponseEntity.code.toString(),
            duration: 8);
        Navigator.of(context).pushNamed(RouteNamedScreens.verification,
            arguments: VerificationArgs(
                type: selectedType.toString(), phone: phoneController.text));
      }
    } else {
      setState(() {
        status = 2;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColorManager.white,
          content: AppTextWidget(
            text: utf8.decode(response.bodyBytes),
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
                controller: phoneController,
                onChanged: (p0) {},
                validator: (p0) {},
                textInputType: TextInputType.number,
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
                                : AppColorManager.white,
                          ),
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
                          selectedType = 1;
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
                                : AppColorManager.white,
                          ),
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
                  onLoginClicked();
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
